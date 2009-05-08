# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.8.2-r1.ebuild,v 1.1 2009/04/17 16:27:48 kolmodin Exp $

# Brief explanation of the bootstrap logic:
#
# Previous ghc ebuilds have been split into two: ghc and ghc-bin,
# where ghc-bin was primarily used for bootstrapping purposes.
# From now on, these two ebuilds have been combined, with the
# binary USE flag used to determine whether or not the pre-built
# binary package should be emerged or whether ghc should be compiled
# from source.  If the latter, then the relevant ghc-bin for the
# arch in question will be used in the working directory to compile
# ghc from source.
#
# This solution has the advantage of allowing us to retain the one
# ebuild for both packages, and thus phase out virtual/ghc.

# Note to users of hardened gcc-3.x:
#
# If you emerge ghc with hardened gcc it should work fine (because we
# turn off the hardened features that would otherwise break ghc).
# However, emerging ghc while using a vanilla gcc and then switching to
# hardened gcc (using gcc-config) will leave you with a broken ghc. To
# fix it you would need to either switch back to vanilla gcc or re-emerge
# ghc (or ghc-bin). Note that also if you are using hardened gcc-3.x and
# you switch to gcc-4.x that this will also break ghc and you'll need to
# re-emerge ghc (or ghc-bin). People using vanilla gcc can switch between
# gcc-3.x and 4.x with no problems.

inherit base bash-completion eutils flag-o-matic toolchain-funcs ghc-package versionator

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

# discover if this is a snapshot release
IS_SNAPSHOT="$(get_version_component_range 4)" # non-empty if snapshot
EXTRA_SRC_URI="${PV}"
[[ "${IS_SNAPSHOT}" ]] && EXTRA_SRC_URI="stable/dist"

# by using a bundled precompiled readline library we can use the bundled ghc
# binary to bootstrap, even if it was linked with libreadline-5 and the user has
# upgraded to libreadline-6.
READLINE_PV="5.2_p13"
READLINE_P="readline-${READLINE_PV}"

SRC_URI="http://haskell.org/ghc/dist/${EXTRA_SRC_URI}/${P}-src.tar.bz2
	amd64?	( mirror://gentoo/ghc-bin-${PV}-amd64.tbz2
			  http://haskell.org/~kolmodin/ghc-bundled-${READLINE_P}-amd64.tbz2 )
	x86?	( mirror://gentoo/ghc-bin-${PV}-x86.tbz2
			  http://haskell.org/~kolmodin/ghc-bundled-${READLINE_P}-x86.tbz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc ghcbootstrap"

RDEPEND="
	!dev-lang/ghc-bin
	>=sys-devel/gcc-2.95.3
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-5"

DEPEND="${RDEPEND}
	ghcbootstrap? (	doc? (	~app-text/docbook-xml-dtd-4.2
							app-text/docbook-xsl-stylesheets
							>=dev-libs/libxslt-1.1.2
							>=dev-haskell/haddock-0.8 ) )"
# In the ghcbootstrap case we rely on the developer having
# >=ghc-5.04.3 on their $PATH already

append-ghc-cflags() {
	local flag compile assemble link
	for flag in $*; do
		case ${flag} in
			compile)	compile="yes";;
			assemble)	assemble="yes";;
			link)		link="yes";;
			*)
				[[ ${compile}  ]] && GHC_CFLAGS="${GHC_CFLAGS} -optc${flag}"
				[[ ${assemble} ]] && GHC_CFLAGS="${GHC_CFLAGS} -opta${flag}"
				[[ ${link}     ]] && GHC_CFLAGS="${GHC_CFLAGS} -optl${flag}";;
		esac
	done
}

ghc_setup_cflags() {
	# We need to be very careful with the CFLAGS we ask ghc to pass through to
	# gcc. There are plenty of flags which will make gcc produce output that
	# breaks ghc in various ways. The main ones we want to pass through are
	# -mcpu / -march flags. These are important for arches like alpha & sparc.
	# We also use these CFLAGS for building the C parts of ghc, ie the rts.
	strip-flags
	strip-unsupported-flags
	filter-flags -fPIC

	GHC_CFLAGS=""
	for flag in ${CFLAGS}; do
		case ${flag} in

			# Ignore extra optimisation (ghc passes -O to gcc anyway)
			# -O2 and above break on too many systems
			-O*) ;;

			# Arch and ABI flags are what we're really after
			-m*) append-ghc-cflags compile assemble ${flag};;

			# Debugging flags don't help either. You can't debug Haskell code
			# at the C source level and the mangler discards the debug info.
			-g*) ;;

			# Ignore all other flags, including all -f* flags
		esac
	done

	# hardened-gcc needs to be disabled, because the mangler doesn't accept
	# its output.
	gcc-specs-pie && append-ghc-cflags compile link	-nopie
	gcc-specs-ssp && append-ghc-cflags compile		-fno-stack-protector

	# We also add -Wa,--noexecstack to get ghc to generate .o files with
	# non-exectable stack. This it a hack until ghc does it itself properly.
	append-ghc-cflags assemble		"-Wa,--noexecstack"
}

pkg_setup() {
	if use ghcbootstrap; then
		ewarn "You requested ghc bootstrapping, this is usually only used"
		ewarn "by Gentoo developers to make binary .tbz2 packages for"
		ewarn "use with the ghc ebuild's USE=\"binary\" feature."
		[[ -z $(type -P ghc) ]] && \
			die "Could not find a ghc to bootstrap with."
	fi
}

src_unpack() {
	base_src_unpack
	ghc_setup_cflags

	# Modify the ghc driver script to use GHC_CFLAGS
	sed -i -e "s|\$\$TOPDIROPT|\$\$TOPDIROPT ${GHC_CFLAGS}|" \
		"${S}/driver/ghc/Makefile"

	if ! use ghcbootstrap; then
		# Relocate from /usr to ${WORKDIR}/usr
		sed -i -e "s|/usr|${WORKDIR}/usr|g" \
			"${WORKDIR}/usr/bin/ghc-${PV}" \
			"${WORKDIR}/usr/bin/ghci-${PV}" \
			"${WORKDIR}/usr/bin/ghc-pkg-${PV}" \
			"${WORKDIR}/usr/bin/hsc2hs" \
			"${WORKDIR}/usr/$(get_libdir)/${P}/package.conf" \
			|| die "Relocating ghc from /usr to workdir failed"
	fi
}

src_compile() {
	# find where the .so for readline-5 lives
	# could either be /lib or /lib64
	for lib_path in lib{,64} ; do
		if [[ -e "${WORKDIR}/${lib_path}/libreadline.so" ]]; then
			# make sure ghc will find readline
			export LD_LIBRARY_PATH="${WORKDIR}/${lib_path}:${LD_LIBRARY_PATH}"
			export FOUND_READLINE=yes
		fi
	done

	if [[ -z "${FOUND_READLINE}" ]]; then
		die "Could not locate bundled libreadline.so"
	else
		einfo "Found readline: ${LD_LIBRARY_PATH}"
	fi

	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# Put docs into the right place, ie /usr/share/doc/ghc-${PV}
	echo "docdir = /usr/share/doc/${P}" >> mk/build.mk
	echo "htmldir = /usr/share/doc/${P}" >> mk/build.mk

	# We also need to use the GHC_CFLAGS flags when building ghc itself
	echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
	echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk

	# We can't depend on haddock except when bootstrapping when we
	# must build docs and include them into the binary .tbz2 package
	if use ghcbootstrap && use doc; then
		echo XMLDocWays="html" >> mk/build.mk
		echo HADDOCK_DOCS=YES >> mk/build.mk
	else
		echo XMLDocWays="" >> mk/build.mk
	fi

	# circumvent a very strange bug that seems related with ghc producing
	# too much output while being filtered through tee (e.g. due to
	# portage logging) reported as bug #111183
	echo "SRC_HC_OPTS+=-w" >> mk/build.mk

	# GHC build system knows to build unregisterised on alpha and hppa,
	# but we have to tell it to build unregisterised on some arches
	if use alpha || use hppa || use ia64 || use ppc64 || use sparc; then
		echo "GhcUnregisterised=YES" >> mk/build.mk
		echo "GhcWithInterpreter=NO" >> mk/build.mk
		echo "GhcWithNativeCodeGen=NO" >> mk/build.mk
		echo "SplitObjs=NO" >> mk/build.mk
		echo "GhcRTSWays := debug" >> mk/build.mk
		echo "GhcNotThreaded=YES" >> mk/build.mk
	fi

	# Get ghc from the unpacked binary .tbz2
	# except when bootstrapping we just pick ghc up off the path
	if ! use ghcbootstrap; then
		export PATH="${WORKDIR}/usr/bin:${PATH}"
	fi

	econf || die "econf failed"

	emake all || die "make failed"
}

src_install() {
	local insttarget="install"

	# We only built docs if we were bootstrapping, otherwise
	# we copy them out of the unpacked binary .tbz2
	if use doc; then
		if use ghcbootstrap; then
			insttarget="${insttarget} install-docs"
		else
			mkdir -p "${D}/usr/share/doc"
			mv "${WORKDIR}/usr/share/doc/${P}" "${D}/usr/share/doc" \
				|| die "failed to copy docs"
		fi
	fi

	emake -j1 ${insttarget} \
		DESTDIR="${D}" \
		|| die "make ${insttarget} failed"

	dodoc "${S}/README" "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"

	dosbin "${FILESDIR}/ghc-updater"

	dobashcompletion "${FILESDIR}/ghc-bash-completion"

	cp -p "${D}/usr/$(get_libdir)/${P}/package.conf"{,.shipped} \
		|| die "failed to copy package.conf"
}

pkg_postinst() {
	ghc-reregister

	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc, please run:"
	ewarn "      /usr/sbin/ghc-updater"
	ewarn "to re-merge all ghc-based Haskell libraries."

	bash-completion_pkg_postinst
}

pkg_prerm() {
	# Overwrite the (potentially) modified package.conf with a copy of the
	# original one, so that it will be removed during uninstall.

	PKG="${ROOT}/usr/$(get_libdir)/${P}/package.conf"

	cp -p "${PKG}"{.shipped,}

	[[ -f ${PKG}.old ]] && rm "${PKG}.old"
}

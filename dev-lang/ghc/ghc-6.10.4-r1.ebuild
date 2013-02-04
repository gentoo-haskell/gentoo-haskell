# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.6.ebuild,v 1.6 2007/07/06 00:46:24 dcoutts Exp $

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

inherit base autotools bash-completion eutils flag-o-matic multilib toolchain-funcs ghc-package versionator pax-utils

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

# discover if this is a snapshot release
IS_SNAPSHOT="$(get_version_component_range 4)" # non-empty if snapshot
EXTRA_SRC_URI="${PV}"
[[ "${IS_SNAPSHOT}" ]] && EXTRA_SRC_URI="stable/dist"

arch_binaries=""

arch_binaries="$arch_binaries alpha? ( http://code.haskell.org/~ivanm/ghc-bin-${PV}-alpha.tbz2 )"
arch_binaries="$arch_binaries x86?   ( http://code.haskell.org/~ivanm/ghc-bin-${PV}-x86.tbz2 )"
arch_binaries="$arch_binaries amd64? ( http://haskell.org/~kolmodin/ghc-bin-${PVR}-amd64.tbz2 )"
arch_binaries="$arch_binaries ia64?  ( http://code.haskell.org/~slyfox/ghc-ia64/ghc-bin-${PV}-ia64.tbz2 )"
arch_binaries="$arch_binaries sparc? ( http://haskell.org/~duncan/ghc/ghc-bin-${PV}-sparc.tbz2 )"
arch_binaries="$arch_binaries ppc64? ( http://code.haskell.org/~slyfox/ghc-ppc64/ghc-bin-${PV}-ppc64.tbz2 )"
arch_binaries="$arch_binaries ppc?   ( http://code.haskell.org/~slyfox/ghc-ppc/ghc-bin-${PV}-ppc.tbz2 )"

SRC_URI="!binary? ( http://haskell.org/ghc/dist/${EXTRA_SRC_URI}/${P}-src.tar.bz2 )
	!ghcbootstrap? ( $arch_binaries )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="binary doc ghcbootstrap"

RDEPEND="
	>=sys-devel/gcc-2.95.3
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	!<dev-haskell/haddock-2.4.2"
# earlier versions than 2.4.2 of haddock only works with older ghc releases

DEPEND="${RDEPEND}
	ghcbootstrap? (	doc? (	~app-text/docbook-xml-dtd-4.2
							app-text/docbook-xsl-stylesheets
							>=dev-libs/libxslt-1.1.2 ) )"
# In the ghcbootstrap case we rely on the developer having
# >=ghc-5.04.3 on their $PATH already

PDEPEND="!ghcbootstrap? ( =app-admin/haskell-updater-0.9* )"

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

	# prevent from failind building unregisterised ghc:
	# http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg171602.html
	use ppc64 && append-ghc-cflags compile -mminimal-toc

	# We also add -Wa,--noexecstack to get ghc to generate .o files with
	# non-exectable stack. This it a hack until ghc does it itself properly.
	append-ghc-cflags assemble		"-Wa,--noexecstack"
}

pkg_setup() {
	if use ghcbootstrap; then
		ewarn "You requested ghc bootstrapping, this is usually only used"
		ewarn "by Gentoo developers to make binary .tbz2 packages for"
		ewarn "use with the ghc ebuild's USE=\"binary\" feature."
		use binary && \
			die "USE=\"ghcbootstrap binary\" is not a valid combination."
		[[ -z $(type -P ghc) ]] && \
			die "Could not find a ghc to bootstrap with."
	#else
	elif false; then

		eerror "No binary .tbz2 package available yet."

		eerror "Please try emerging with USE=ghcbootstrap and report build"
		eerror "sucess or failure to the haskell team (haskell@gentoo.org)"
		die "No binary available for this arch yet, USE=ghcbootstrap"
	fi
}

src_unpack() {
	# Create the ${S} dir if we're using the binary version
	use binary && mkdir "${S}"

	base_src_unpack
	source "${FILESDIR}/ghc-apply-gmp-hack" "$(get_libdir)"

	ghc_setup_cflags

	if ! use ghcbootstrap; then
		# Modify the wrapper script from the binary tarball to use GHC_CFLAGS.
		# See bug #313635.
		sed -i -e "s|wrapped|wrapped ${GHC_CFLAGS}|" \
			"${WORKDIR}/usr/bin/ghc-${PV}"

		# allow hardened users use vanilla biary to bootstrap ghc
		# ghci uses mmap with rwx protection at it implements dynamic
		# linking on it's own (bug #299709)
		pax-mark -m "${WORKDIR}/usr/$(get_libdir)/${P}/ghc"
	fi

	if use binary; then

		# Move unpacked files to the expected place
		mv "${WORKDIR}/usr" "${S}"
	else
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

		# Hack to prevent haddock being installed, remove when ./configure
		# supports something better to not build docs or haddock.
		sed -i -e 's/DO_NOT_INSTALL =/DO_NOT_INSTALL = haddock/' \
			"${S}/utils/Makefile"

		# Modify the ghc driver script to use GHC_CFLAGS
		sed -i -e "s|wrapped|wrapped ${GHC_CFLAGS}|" \
	                "${S}/ghc/ghc.wrapper"

		cd "${S}"

		# disable cabal built binary stripping (solves bug #299492)
		# as installPackage strips them by default
		epatch "${FILESDIR}/ghc-6.10.4-disable-strip.patch"

		# patch aclocal.m4 and configure.ac to work with >=autoconf-2.64
		epatch "${FILESDIR}/${P}-autoconf.patch"

		# fix configure.ac to detect libm need
		#    http://bugs.gentoo.org/show_bug.cgi?id=293208
		#    http://hackage.haskell.org/trac/ghc/ticket/3730
		epatch "${FILESDIR}/ghc-6.10.4-libm-detection.patch"

		# -r and --relax are incompatible
		epatch "${FILESDIR}/ghc-6.10.4-ia64-fixed-relax.patch"

		# prevent from wiping upper address bits used in cache lookup
		epatch "${FILESDIR}/ghc-6.10.4-ia64-storage-manager-fix.patch"

		# as we have changed the build system
		eautoreconf
	fi
}

src_compile() {
	if ! use binary; then

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
			echo HADDOCK_DOCS=NO >> mk/build.mk
		fi

		# circumvent a very strange bug that seems related with ghc producing
		# too much output while being filtered through tee (e.g. due to
		# portage logging) reported as bug #111183
		echo "SRC_HC_OPTS+=-w" >> mk/build.mk

		# some arches do not support ELF parsing for ghci module loading
		# PPC64: never worked (should be easy to implement)
		# alpha: never worked
		if use alpha || use ppc64; then
			echo "GhcWithInterpreter=NO" >> mk/build.mk
		fi

		# we have to tell it to build unregisterised on some arches
		# ppc64: EvilMangler currently does not understand some TOCs
		# ia64: EvilMangler bitrot
		if use alpha || use ia64 || use ppc64; then
			echo "GhcUnregisterised=YES" >> mk/build.mk
			echo "GhcWithNativeCodeGen=NO" >> mk/build.mk
			echo "SplitObjs=NO" >> mk/build.mk
			echo "GhcRTSWays := debug" >> mk/build.mk
			echo "GhcNotThreaded=YES" >> mk/build.mk
		fi

		# Have "ld -r --relax" problem with split-objs on sparc:
		if use sparc; then
			echo "SplitObjs=NO" >> mk/build.mk
		fi

		# Get ghc from the unpacked binary .tbz2
		# except when bootstrapping we just pick ghc up off the path
		if ! use ghcbootstrap; then
			export PATH="${WORKDIR}/usr/bin:${PATH}"
		fi

		econf || die "econf failed"

		# LC_ALL needs to workaround ghc's ParseCmm failure on some (es) locales
		# bug #202212 / http://hackage.haskell.org/trac/ghc/ticket/4207
		LC_ALL=C emake -j1 all || die "make failed"

	fi # ! use binary
}

src_install() {
	if use binary; then
		mv "${S}/usr" "${D}"

		# Remove the docs if not requested
		if ! use doc; then
			rm -rf "${D}/usr/share/doc/${P}/*/" \
				"${D}/usr/share/doc/${P}/*.html" \
				|| die "could not remove docs (P vs PF revision mismatch?)"
		fi
	else
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

		# ghci uses mmap with rwx protection at it implements dynamic
		# linking on it's own (bug #299709)
		# so mark resulting binary
		pax-mark -m "${D}/usr/$(get_libdir)/${P}/ghc"

		dodoc "${S}/README" "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"

		dobashcompletion "${FILESDIR}/ghc-bash-completion"

		cp -p "${D}/usr/$(get_libdir)/${P}/package.conf"{,.shipped} \
			|| die "failed to copy package.conf"
	fi
}

pkg_postinst() {
	# 'ghc-pkg check' fails in ghc 6.10.2, with the error message:
	# There are problems in package rts-1.0:
	#    include-dirs: PAPI_INCLUDE_DIR doesn't exist or isn't a directory
	# Upstream suggests this solution to fix it:
	export PATH="/usr/bin:${PATH}"
	$(ghc-getghcpkg) describe rts | sed 's/PAPI_INCLUDE_DIR//' | $(ghc-getghcpkg) update -

	ghc-reregister

	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc,"
	ewarn "once app-admin/haskell-updater has installed please run:"
	ewarn "      /usr/sbin/haskell-updater --upgrade"
	ewarn "to re-build all ghc-based Haskell libraries."

	bash-completion_pkg_postinst
}

pkg_prerm() {
	# Be very careful here... Call order when upgrading is (according to PMS):
	# * src_install for new package
	# * pkg_preinst for new package
	# * pkg_postinst for new package
	# * pkg_prerm for the package being replaced
	# * pkg_postrm for the package being replaced
	# so you'll actually be touching the new packages files, not the one you
	# uninstall, due to that or installation directory ${P} will be the same for
	# both packages.

	# Call order for reinstalling is (according to PMS):
	# * src_install
	# * pkg_preinst
	# * pkg_prerm for the package being replaced
	# * pkg_postrm for the package being replaced
	# * pkg_postinst

	# Overwrite the (potentially) modified package.conf with a copy of the
	# original one, so that it will be removed during uninstall.

	PKG="${ROOT}/usr/$(get_libdir)/${P}/package.conf"

	cp -p "${PKG}"{.shipped,}

	[[ -f ${PKG}.old ]] && rm "${PKG}.old"
}

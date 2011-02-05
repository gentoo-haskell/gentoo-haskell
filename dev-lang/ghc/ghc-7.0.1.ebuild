# Copyright 1999-2010 Gentoo Foundation
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

# we don't have any binaries yet
arch_binaries=""

#arch_binaries="$arch_binaries alpha? ( http://code.haskell.org/~slyfox/ghc-alpha/ghc-bin-${PV}-alpha.tbz2 )"
#arch_binaries="$arch_binaries x86?   ( mirror://gentoo/ghc-bin-${PV}-x86.tbz2 )"
#arch_binaries="$arch_binaries amd64? ( mirror://gentoo/ghc-bin-${PV}-amd64.tbz2 )"
#arch_binaries="$arch_binaries ia64?  ( http://code.haskell.org/~slyfox/ghc-ia64/ghc-bin-${PV}-ia64-fixed-fiw.tbz2 )"
#arch_binaries="$arch_binaries sparc? ( http://code.haskell.org/~slyfox/ghc-sparc/ghc-bin-${PV}-sparc.tbz2 )"
#arch_binaries="$arch_binaries ppc64? ( mirror://gentoo/ghc-bin-${PV}-ppc64.tbz2 )"
#arch_binaries="$arch_binaries ppc? ( mirror://gentoo/ghc-bin-${PV}-ppc.tbz2 )"

# various ports:
#arch_binaries="$arch_binaries x86-fbsd? ( http://code.haskell.org/~slyfox/ghc-x86-fbsd/ghc-bin-${PV}-x86-fbsd.tbz2 )"

SRC_URI="!binary? ( http://www.haskell.org/ghc/dist/${PV}/${P}-src.tar.bz2 )"
#	!ghcbootstrap? ( $arch_binaries )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc ghcbootstrap" # removed binary
IUSE+=" ghcquickbuild" # overlay only

RDEPEND="
	!dev-lang/ghc-bin
	>=sys-devel/gcc-2.95.3
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-5
	!<dev-haskell/haddock-2.4.2"
# earlier versions than 2.4.2 of haddock only works with older ghc releases

# force dependency on >=gmp-5, even if >=gmp-4.1 would be enough. this is due to
# that we want the binaries to use the latest versioun available, and not to be
# built against gmp-4

DEPEND="${RDEPEND}
	ghcbootstrap? (	doc? (	~app-text/docbook-xml-dtd-4.2
							app-text/docbook-xsl-stylesheets
							>=dev-libs/libxslt-1.1.2 ) )"
# In the ghcbootstrap case we rely on the developer having
# >=ghc-5.04.3 on their $PATH already

#PDEPEND="!ghcbootstrap? ( =app-admin/haskell-updater-1.1* )"
PDEPEND="
	${PDEPEND}
	dev-haskell/syb"

# use undocumented feature STRIP_MASK to fix this issue:
# http://hackage.haskell.org/trac/ghc/ticket/3580
STRIP_MASK="*/HSffi.o"

append-ghc-cflags() {
	local flag compile assemble link
	for flag in $*; do
		case ${flag} in
			compile)	compile="yes";;
			assemble)	assemble="yes";;
			link)		link="yes";;
			*)
				[[ ${compile}  ]] && GHC_FLAGS="${GHC_FLAGS} -optc${flag}" CFLAGS="${CFLAGS} ${flag}"
				[[ ${assemble} ]] && GHC_FLAGS="${GHC_FLAGS} -opta${flag}" CFLAGS="${CFLAGS} ${flag}"
				[[ ${link}     ]] && GHC_FLAGS="${GHC_FLAGS} -optl${flag}" FILTERED_LDFLAGS="${FILTERED_LDFLAGS} ${flag}";;
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

	GHC_FLAGS=""
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

	FILTERED_LDFLAGS=""
	for flag in ${LDFLAGS}; do
		case ${flag} in
			# Pass the canary. we don't quite respect LDFLAGS, but we have an excuse!
			"-Wl,--hash-style="*) append-ghc-cflags link ${flag};;

			# Ignore all other flags
		esac
	done

	# hardened-gcc needs to be disabled, because the mangler doesn't accept
	# its output.
	gcc-specs-pie && append-ghc-cflags compile link	-nopie
	gcc-specs-ssp && append-ghc-cflags compile		-fno-stack-protector

	# prevent from failind building unregisterised ghc:
	# http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg171602.html
	use ppc64 && append-ghc-cflags compile -mminimal-toc
	# fix the similar issue as ppc64 TOC on ia64. ia64 has limited size of small data
	# currently ghc fails to build haddock
	# http://osdir.com/ml/gnu.binutils.bugs/2004-10/msg00050.html
	use ia64 && append-ghc-cflags compile -G0
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
	else
		eerror "No binary .tbz2 package available yet for your arch."
		#
		#eerror "No binary .tbz2 package available yet."
		#
		eerror "Please try emerging with USE=ghcbootstrap and report build"
		eerror "sucess or failure to the haskell team (haskell@gentoo.org)"
		die "No binary available for this arch yet, USE=ghcbootstrap"
	fi
}

src_unpack() {
	# Create the ${S} dir if we're using the binary version
	use binary && mkdir "${S}"

	base_src_unpack

	# ghc7: we don't need gmp hack any more, depend on >=gmp-5
	#source "${FILESDIR}/ghc-apply-gmp-hack" "$(get_libdir)"

	ghc_setup_cflags

	if ! use ghcbootstrap; then
		# Modify the wrapper script from the binary tarball to use GHC_FLAGS.
		# See bug #313635.
		sed -i -e "s|\"\$topdir\"|\"\$topdir\" ${GHC_FLAGS}|" \
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
				"${WORKDIR}/usr/$(get_libdir)/${P}/package.conf.d/"* \
				|| die "Relocating ghc from /usr to workdir failed"

			# regenerate the binary package cache
			"${WORKDIR}/usr/bin/ghc-pkg" recache
		fi

		sed -i -e "s|\"\$topdir\"|\"\$topdir\" ${GHC_FLAGS}|" \
			"${S}/ghc/ghc.wrapper"

		cd "${S}" # otherwise epatch will break

		epatch "${FILESDIR}/ghc-6.12.1-configure-CHOST.patch"
		epatch "${FILESDIR}/ghc-6.12.2-configure-CHOST-part2.patch"
		epatch "${FILESDIR}/ghc-6.12.3-configure-CHOST-freebsd.patch"

		# This patch unbreaks ghci on GRSEC kernels hardened with
		# TPE (Trusted Path Execution) protection.
		epatch "${FILESDIR}/ghc-7.0.1-libffi-incorrect-detection-of-selinux.patch"

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

		# The settings that give you the fastest complete GHC build are these:
		if use ghcquickbuild; then
			echo "SRC_HC_OPTS     = -H64m -O0 -fasm" >> mk/build.mk
			echo "GhcStage1HcOpts = -O -fasm" >> mk/build.mk
			echo "GhcStage2HcOpts = -O0 -fasm" >> mk/build.mk
			echo "GhcLibHcOpts    = -O0 -fasm" >> mk/build.mk
			echo "GhcLibWays      = v" >> mk/build.mk
			echo "SplitObjs       = NO" >> mk/build.mk
		fi
		# However, note that the libraries are built without optimisation, so
		# this build isn't very useful. The resulting compiler will be very
		# slow. On a 4-core x86 machine using MAKEOPTS="-j10", this build was
		# timed at less than 8 minutes.

		# We also need to use the GHC_FLAGS flags when building ghc itself
		echo "SRC_HC_OPTS+=${GHC_FLAGS}" >> mk/build.mk
		echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk
		echo "SRC_LD_OPTS+=${FILTERED_LDFLAGS}" >> mk/build.mk

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
		# arm: unimplemented or never worked
		if use alpha || use ppc64 || use arm; then
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

		# arm: no EvilMangler support, no NCG support
		if use arm; then
			echo "GhcUnregisterised=YES" >> mk/build.mk
			echo "GhcWithNativeCodeGen=NO" >> mk/build.mk
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

		# Since GHC 6.12.2 the GHC wrappers store which GCC version GHC was
		# compiled with, by saving the path to it. The purpose is to make sure
		# that GHC will use the very same gcc version when it compiles haskell
		# sources, as the extra-gcc-opts files contains extra gcc options which
		# match only this GCC version.
		# However, this is not required in Gentoo, as only modern GCCs are used
		# (>4).
		# Instead, this causes trouble when for example ccache is used during
		# compilation, but we don't want the wrappers to point to ccache.
		# Due to the above, we simply set GCC to be "gcc". When compiling ghc it
		# might point to ccache, once installed it will point to the users
		# regular gcc.

		econf --with-gcc=gcc || die "econf failed"

		# LC_ALL needs to workaround ghc's ParseCmm failure on some (es) locales
		# bug #202212 / http://hackage.haskell.org/trac/ghc/ticket/4207
		LC_ALL=C emake all || die "make failed"

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
			if ! use ghcbootstrap; then
				mkdir -p "${D}/usr/share/doc"
				mv "${WORKDIR}/usr/share/doc/${P}" "${D}/usr/share/doc" \
					|| die "failed to copy docs"
			fi
		fi

		emake -j1 ${insttarget} \
			DESTDIR="${D}" \
			|| die "make ${insttarget} failed"

		# remove wrapper and linker
		rm -f "${D}"/usr/bin/haddock*

		# ghci uses mmap with rwx protection at it implements dynamic
		# linking on it's own (bug #299709)
		# so mark resulting binary
		pax-mark -m "${D}/usr/$(get_libdir)/${P}/ghc"

		dodoc "${S}/README" "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"

		dobashcompletion "${FILESDIR}/ghc-bash-completion"

	fi

	# path to the package.cache
	PKGCACHE="${D}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"

	# copy the package.conf, including timestamp, save it so we later can put it
	# back before uninstalling, or when upgrading.
	cp -p "${PKGCACHE}"{,.shipped} \
		|| die "failed to copy package.conf.d/package.cache"
}

pkg_preinst() {
	# have we got an earlier version of ghc installed?
	if has_version "<${CATEGORY}/${PF}"; then
		haskell_updater_warn="1"
	fi
}

pkg_postinst() {
	ghc-reregister

	# path to the package.cache
	PKGCACHE="${ROOT}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"

	# give the cache a new timestamp, it must be as recent as
	# the package.conf.d directory.
	touch "${PKGCACHE}"

	if [[ "${haskell_updater_warn}" == "1" ]]; then
		ewarn
		ewarn "\e[1;31m************************************************************************\e[0m"
		ewarn
		ewarn "You have just upgraded from an older version of GHC."
		ewarn "You may have to run"
		ewarn "      'haskell-updater --upgrade'"
		ewarn "to rebuild all ghc-based Haskell libraries."
		ewarn
		ewarn "\e[1;31m************************************************************************\e[0m"
		ewarn
		ebeep 12
	fi

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

	# Overwrite the modified package.cache with a copy of the
	# original one, so that it will be removed during uninstall.

	PKGCACHE="${ROOT}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"
	rm -rf "${PKGCACHE}"

	cp -p "${PKGCACHE}"{.shipped,}
}

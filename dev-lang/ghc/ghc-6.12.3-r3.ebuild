# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.12.3-r1.ebuild,v 1.1 2011/03/27 19:44:17 slyfox Exp $

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

EAPI="3"

inherit base autotools bash-completion eutils flag-o-matic multilib toolchain-funcs ghc-package versionator pax-utils

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

arch_binaries=""

arch_binaries="$arch_binaries alpha? ( http://code.haskell.org/~slyfox/ghc-alpha/ghc-bin-${PV}-alpha-haddock.tbz2 )"
arch_binaries="$arch_binaries x86?   ( mirror://gentoo/ghc-bin-${PV}-x86.tbz2 )"
arch_binaries="$arch_binaries amd64? ( mirror://gentoo/ghc-bin-${PV}-amd64.tbz2 )"
arch_binaries="$arch_binaries ia64?  ( http://code.haskell.org/~slyfox/ghc-ia64/ghc-bin-${PV}-ia64-haddock.tbz2 )"
arch_binaries="$arch_binaries sparc? ( http://code.haskell.org/~slyfox/ghc-sparc/ghc-bin-${PV}-sparc.tbz2 )"
arch_binaries="$arch_binaries ppc64? ( mirror://gentoo/ghc-bin-${PV}-ppc64.tbz2 )"
arch_binaries="$arch_binaries ppc? ( mirror://gentoo/ghc-bin-${PV}-ppc.tbz2 )"

# various ports:
arch_binaries="$arch_binaries x86-fbsd? ( http://code.haskell.org/~slyfox/ghc-x86-fbsd/ghc-bin-${PV}-x86-fbsd.tbz2 )"

arch_binaries="$arch_binaries x86-macos? ( http://www.haskell.org/ghc/dist/6.10.1/maeder/ghc-6.10.1-i386-apple-darwin.tar.bz2 )"
arch_binaries="$arch_binaries ppc-macos? ( http://www.haskell.org/ghc/dist/6.10.1/maeder/ghc-6.10.1-powerpc-apple-darwin.tar.bz2 )"
arch_binaries="$arch_binaries x86-solaris? ( http://www.haskell.org/ghc/dist/6.10.4/maeder/ghc-6.10.4-i386-unknown-solaris2.tar.bz2 )"
arch_binaries="$arch_binaries sparc-solaris? ( http://www.haskell.org/ghc/dist/6.10.4/maeder/ghc-6.10.4-sparc-sun-solaris2.tar.bz2 )"

SRC_URI="!binary? ( http://darcs.haskell.org/download/dist/${PV}/${P}-src.tar.bz2 )
	!ghcbootstrap? ( $arch_binaries )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="binary doc ghcbootstrap"

RDEPEND="
	!kernel_Darwin? ( >=sys-devel/gcc-2.95.3 )
	kernel_linux? ( >=sys-devel/binutils-2.17 )
	kernel_SunOS? ( >=sys-devel/binutils-2.17 )
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	!<dev-haskell/haddock-2.4.2
	sys-libs/ncurses[unicode]"
# earlier versions than 2.4.2 of haddock only works with older ghc releases

DEPEND="${RDEPEND}
	ghcbootstrap? (	doc? (	~app-text/docbook-xml-dtd-4.2
							app-text/docbook-xsl-stylesheets
							>=dev-libs/libxslt-1.1.2 ) )"
# In the ghcbootstrap case we rely on the developer having
# >=ghc-5.04.3 on their $PATH already

PDEPEND="!ghcbootstrap? ( || ( =app-admin/haskell-updater-1.2* =app-admin/haskell-updater-1.1* ) )"

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
	# fix the similar issue as ppc64 TOC on ia64. ia64 has limited size of small data
	# currently ghc fails to build haddock
	# http://osdir.com/ml/gnu.binutils.bugs/2004-10/msg00050.html
	use ia64 && append-ghc-cflags compile -G0
}

# substitutes string $1 to $2 in files $3 $4 ...
relocate_path() {
	local from=$1
	local   to=$2
	shift 2
	local file=
	for file in "$@"
	do
		sed -i -e "s|$from|$to|g" \
		    "$file" || die "path relocation failed for '$file'"
	done
}

# changes hardcoded ghc paths and updates package index
# $1 - new absolute root path
relocate_ghc() {
	local to=$1

	# backup original script to use it later after relocation
	local gp_back="${T}/ghc-pkg-${PV}-orig"
	cp "${WORKDIR}/usr/bin/ghc-pkg-${PV}" "$gp_back" || die "unable to backup ghc-pkg wrapper"

	# Relocate from /usr to ${EPREFIX}/usr
	relocate_path "/usr" "${to}/usr" \
		"${WORKDIR}/usr/bin/ghc-${PV}" \
		"${WORKDIR}/usr/bin/ghci-${PV}" \
		"${WORKDIR}/usr/bin/ghc-pkg-${PV}" \
		"${WORKDIR}/usr/bin/hsc2hs" \
		"${WORKDIR}/usr/$(get_libdir)/${P}/package.conf.d/"*

	# this one we will use to regenerate cache
	# so it shoult point to current tree location
	relocate_path "/usr" "${WORKDIR}/usr" "$gp_back"

	if use prefix; then
		# and insert LD_LIBRARY_PATH entry to EPREFIX dir tree
		# TODO: add the same for darwin's CHOST and it's DYLD_
		local new_ldpath='LD_LIBRARY_PATH="'${EPREFIX}/$(get_libdir):${EPREFIX}/usr/$(get_libdir)'${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"\nexport LD_LIBRARY_PATH'
		sed -i -e '2i'"$new_ldpath" \
			"${WORKDIR}/usr/bin/ghc-${PV}" \
			"${WORKDIR}/usr/bin/ghci-${PV}" \
			"${WORKDIR}/usr/bin/ghc-pkg-${PV}" \
			"$gp_back" \
			"${WORKDIR}/usr/bin/hsc2hs" \
			|| die "Adding LD_LIBRARY_PATH for wrappers failed"
	fi

	# regenerate the binary package cache
	"$gp_back" recache || die "failed to update cache after relocation"
	rm "$gp_back"
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
	elif false; then
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

	# the Solaris and Darwin binaries from ghc (maeder) need to be
	# unpacked separately, so prevent them from being unpacked
	local ONLYA=${A}
	case ${CHOST} in
		*-darwin* | *-solaris*)  ONLYA=${P}-src.tar.bz2  ;;
	esac
	unpack ${ONLYA}
}

src_prepare() {
	[[ ${CHOST} != *-darwin* ]] && \
		source "${FILESDIR}/ghc-apply-gmp-hack" "$(get_libdir)"

	ghc_setup_cflags

	if ! use ghcbootstrap; then
		# Modify the wrapper script from the binary tarball to use GHC_CFLAGS.
		# See bug #313635.
		sed -i -e "s|\"\$topdir\"|\"\$topdir\" ${GHC_CFLAGS}|" \
			"${WORKDIR}/usr/bin/ghc-${PV}"

		# allow hardened users use vanilla binary to bootstrap ghc
		# ghci uses mmap with rwx protection at it implements dynamic
		# linking on it's own (bug #299709)
		pax-mark -m "${WORKDIR}/usr/$(get_libdir)/${P}/ghc"
	fi

	if use binary; then
		if use prefix; then
			relocate_ghc "${EPREFIX}"
		fi

		# Move unpacked files to the expected place
		mv "${WORKDIR}/usr" "${S}"
	else
		if ! use ghcbootstrap; then
			case ${CHOST} in
				*-darwin* | *-solaris*)
				mkdir "${WORKDIR}"/ghc-bin-installer || die
				pushd "${WORKDIR}"/ghc-bin-installer > /dev/null || die
				use sparc-solaris && unpack ghc-6.10.4-sparc-sun-solaris2.tar.bz2
				use x86-solaris && unpack ghc-6.10.4-i386-unknown-solaris2.tar.bz2
				use ppc-macos && unpack ghc-6.10.1-powerpc-apple-darwin.tar.bz2
				use x86-macos && unpack ghc-6.10.1-i386-apple-darwin.tar.bz2
				popd > /dev/null

				pushd "${WORKDIR}"/ghc-bin-installer/ghc-6.10.? > /dev/null || die
				# fix the binaries so they run, on Solaris we need an
				# LD_LIBRARY_PATH which has our prefix libdirs, on
				# Darwin we need to replace the frameworks with our libs
				# from the prefix fix before installation, because some
				# of the tools are actually used during configure/make
				if [[ ${CHOST} == *-solaris* ]] ; then
					export LD_LIBRARY_PATH="${EPREFIX}/$(get_libdir):${EPREFIX}/usr/$(get_libdir):${LD_LIBRARY_PATH}"
				elif [[ ${CHOST} == *-darwin* ]] ; then
					# http://hackage.haskell.org/trac/ghc/ticket/2942
					pushd utils/haddock/dist-install/build > /dev/null
					ln -s Haddock haddock >& /dev/null # fails on IN-sensitive
					popd > /dev/null

					local readline_framework=GNUreadline.framework/GNUreadline
					local gmp_framework=/opt/local/lib/libgmp.3.dylib
					local ncurses_file=/opt/local/lib/libncurses.5.dylib
					for binary in $(scanmacho -BRE MH_EXECUTE -F '%F' .) ; do
						install_name_tool -change \
							${readline_framework} \
							"${EPREFIX}"/lib/libreadline.dylib \
							${binary} || die
						install_name_tool -change \
							${gmp_framework} \
							"${EPREFIX}"/usr/lib/libgmp.dylib \
							${binary} || die
						install_name_tool -change \
							${ncurses_file} \
							"${EPREFIX}"/usr/lib/libncurses.dylib \
							${binary} || die
					done
					# we don't do frameworks!
					sed -i \
						-e 's/\(frameworks = \)\["GMP"\]/\1[]/g' \
						-e 's/\(extraLibraries = \)\["m"\]/\1["m","gmp"]/g' \
						rts/package.conf.in || die
				fi

				# it is autoconf, but we really don't want to give it too
				# much arguments, in fact we do the make in-place anyway
				./configure --prefix="${WORKDIR}"/usr || die
				make install || die
				popd > /dev/null
				;;
				*)
				relocate_ghc "${WORKDIR}"
				;;
			esac
		fi

		sed -i -e "s|\"\$topdir\"|\"\$topdir\" ${GHC_CFLAGS}|" \
			"${S}/ghc/ghc.wrapper"

		# Since GHC 6.12.2 the GHC wrappers store which GCC version GHC was
		# compiled with, by saving the path to it. The purpose is to make sure
		# that GHC will use the very same gcc version when it compiles haskell
		# sources, as the extra-gcc-opts files contains extra gcc options which
		# match only this GCC version.
		# However, this is not required in Gentoo, as only modern GCCs are used
		# (>4).
		# Instead, this causes trouble when for example ccache is used during
		# compilation, but we don't want the wrappers to point to ccache.
		# Due to the above, we simply remove GCC from the wrappers, which forces
		# GHC to use GCC from the users path, like previous GHC versions did.

		# Remove path to gcc
		sed -i -e '/pgmgcc/d' \
			"${S}/rules/shell-wrapper.mk"

		# Remove usage of the path to gcc
		sed -i -e 's/-pgmc "$pgmgcc"//' \
		    "${S}/ghc/ghc.wrapper"

		cd "${S}" # otherwise epatch will break

		epatch "${FILESDIR}/ghc-6.12.1-configure-CHOST.patch"
		epatch "${FILESDIR}/ghc-6.12.2-configure-CHOST-part2.patch"
		epatch "${FILESDIR}/ghc-6.12.3-configure-CHOST-freebsd.patch"
		epatch "${FILESDIR}/ghc-6.12.3-configure-CHOST-prefix.patch"

		# -r and --relax are incompatible
		epatch "${FILESDIR}/ghc-6.12.3-ia64-fixed-relax.patch"

		# prevent from wiping upper address bits used in cache lookup
		epatch "${FILESDIR}/ghc-6.12.3-ia64-storage-manager-fix.patch"

		# fixes build failure of adjustor code
		epatch "${FILESDIR}/ghc-6.12.3-alpha-use-libffi-for-foreign-import-wrapper.patch"

		# native adjustor (NA) code is broken: interactive darcs-2.4 coredumps on NA
		epatch "${FILESDIR}/ghc-6.12.3-ia64-use-libffi-for-foreign-import-wrapper.patch"

		# same with NA on ppc
		epatch "${FILESDIR}/ghc-6.12.3-ppc-use-libffi-for-foreign-import-wrapper.patch"

		# substitute outdated macros
		epatch "${FILESDIR}/ghc-6.12.3-autoconf-2.66-4252.patch"

		# ticket 2615, linker scripts
		# breaks Darwin
		[[ ${CHOST} != *-darwin* ]] && \
			epatch "${FILESDIR}/ghc-6.12.3-ticket-2615-linker-script.patch"

		# export typechecker internals even if ghci is disabled
		# http://hackage.haskell.org/trac/ghc/ticket/3558
		epatch "${FILESDIR}/ghc-6.12.3-ghciless-haddock-3558.patch"

		# This patch unbreaks ghci on GRSEC kernels hardened with
		# TPE (Trusted Path Execution) protection.
		epatch "${FILESDIR}/ghc-6.12.3-libffi-incorrect-detection-of-selinux.patch"

		epatch "${FILESDIR}"/${P}-pic-powerpc.patch
		epatch "${FILESDIR}"/${P}-darwin8.patch
		epatch "${FILESDIR}"/${P}-mach-o-relocation-limit.patch
		epatch "${FILESDIR}"/${P}-powerpc-darwin-no-mmap.patch
		epatch "${FILESDIR}"/${PN}-7.0.4-nonthreaded-getNumberOfProcessors.patch

		if use prefix; then
			# Make configure find docbook-xsl-stylesheets from Prefix
			sed -i -e '/^FP_DIR_DOCBOOK_XSL/s:\[.*\]:['"${EPREFIX}"'/usr/share/sgml/docbook/xsl-stylesheets/]:' configure.ac || die
		fi

		# disable bitrot bfd support, bug #522268
		sed -i -e 's/^AC_CHECK_LIB(bfd,    bfd_init)$/dnl &/' configure.ac || die

		# as we have changed the build system
		eautoreconf
	fi
}

src_configure() {
	if ! use binary; then

		# initialize build.mk
		echo '# Gentoo changes' > mk/build.mk

		# Put docs into the right place, ie /usr/share/doc/ghc-${PV}
		echo "docdir = ${EPREFIX}/usr/share/doc/${P}" >> mk/build.mk
		echo "htmldir = ${EPREFIX}/usr/share/doc/${P}" >> mk/build.mk

		# We also need to use the GHC_CFLAGS flags when building ghc itself
		echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
		case $($(tc-getAS) -v 2>&1 </dev/null) in
			*"GNU Binutils"*) # GNU ld
			echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk
			;;
		esac

		# We can't depend on haddock except when bootstrapping when we
		# must build docs and include them into the binary .tbz2 package
		if use ghcbootstrap && use doc; then
			echo "BUILD_DOCBOOK_PDF  = NO"  >> mk/build.mk
			echo "BUILD_DOCBOOK_PS   = NO"  >> mk/build.mk
			echo "BUILD_DOCBOOK_HTML = YES" >> mk/build.mk
			echo "HADDOCK_DOCS       = YES" >> mk/build.mk
		else
			echo "BUILD_DOCBOOK_PDF  = NO" >> mk/build.mk
			echo "BUILD_DOCBOOK_PS   = NO" >> mk/build.mk
			echo "BUILD_DOCBOOK_HTML = NO" >> mk/build.mk
			echo "HADDOCK_DOCS       = NO" >> mk/build.mk
		fi

		sed -e "s|utils/haddock_dist_INSTALL_SHELL_WRAPPER = YES|utils/haddock_dist_INSTALL_SHELL_WRAPPER = NO|" \
		    -i utils/haddock/ghc.mk

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
	fi # ! use binary
}

src_compile() {
	if ! use binary; then
		# LC_ALL needs to workaround ghc's ParseCmm failure on some (es) locales
		# bug #202212 / http://hackage.haskell.org/trac/ghc/ticket/4207
		LC_ALL=C emake -j1 all || die "make failed"
	fi # ! use binary
}

src_install() {
	if use binary; then
		mv "${S}/usr" "${ED}"

		# Remove the docs if not requested
		if ! use doc; then
			rm -rf "${ED}/usr/share/doc/${P}/*/" \
				"${ED}/usr/share/doc/${P}/*.html" \
				|| die "could not remove docs (P vs PF revision mismatch?)"
		fi
	else
		local insttarget="install"

		# We only built docs if we were bootstrapping, otherwise
		# we copy them out of the unpacked binary .tbz2
		if use doc; then
			if ! use ghcbootstrap; then
				mkdir -p "${ED}/usr/share/doc"
				mv "${WORKDIR}/usr/share/doc/${P}" "${ED}/usr/share/doc" \
					|| die "failed to copy docs"
			fi
		fi

		emake -j1 ${insttarget} \
			DESTDIR="${D}" \
			|| die "make ${insttarget} failed"

		# ghci uses mmap with rwx protection at it implements dynamic
		# linking on it's own (bug #299709)
		# so mark resulting binary
		pax-mark -m "${ED}/usr/$(get_libdir)/${P}/ghc"

		dodoc "${S}/README" "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"

		dobashcompletion "${FILESDIR}/ghc-bash-completion"

	fi

	# path to the package.cache
	PKGCACHE="${ED}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"

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
	PKGCACHE="${EROOT}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"

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

	PKGCACHE="${EROOT}/usr/$(get_libdir)/${P}/package.conf.d/package.cache"
	rm -rf "${PKGCACHE}"

	cp -p "${PKGCACHE}"{.shipped,}
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# to make make a crosscompiler use crossdev and symlink ghc tree into
# cross overlay. result would look like 'cross-sparc-unknown-linux-gnu/ghc'
#
# 'CTARGET' definition and 'is_crosscompile' are taken from 'toolchain.eclass'
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} = ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

[[ ${PV} = *9999* ]] && GIT_ECLASS="git-2" || GIT_ECLASS=""

inherit base autotools bash-completion-r1 eutils flag-o-matic ${GIT_ECLASS} multilib toolchain-funcs ghc-package versionator pax-utils

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

EGIT_REPO_URI="https://github.com/ghc/ghc.git"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${P}-src.tar.bz2"
fi
LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="dph doc +ghcbootstrap ghcmakebinary +gmp llvm"
REQUIRED_USE="ghcbootstrap"

RDEPEND="
	!kernel_Darwin? ( >=sys-devel/gcc-2.95.3 )
	kernel_linux? ( >=sys-devel/binutils-2.17 )
	kernel_SunOS? ( >=sys-devel/binutils-2.17 )
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-5
	virtual/libffi
	!<dev-haskell/haddock-2.4.2
	sys-libs/ncurses[unicode]"
# earlier versions than 2.4.2 of haddock only works with older ghc releases

# force dependency on >=gmp-5, even if >=gmp-4.1 would be enough. this is due to
# that we want the binaries to use the latest versioun available, and not to be
# built against gmp-4

DEPEND="${RDEPEND}
	>=dev-haskell/alex-2.3
	>=dev-haskell/happy-1.19
	doc? ( app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	>=dev-libs/libxslt-1.1.2 )"

PDEPEND="
	${PDEPEND}
	llvm? ( sys-devel/llvm )"

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}

append-ghc-cflags() {
	local persistent compile assemble link
	local flag ghcflag

	for flag in $*; do
		case ${flag} in
			persistent)	persistent="yes";;
			compile)	compile="yes";;
			assemble)	assemble="yes";;
			link)		link="yes";;
			*)
				[[ ${compile}  ]] && ghcflag="-optc${flag}"  CFLAGS+=" ${flag}" && GHC_FLAGS+=" ${ghcflag}" &&
					[[ ${persistent} ]] && GHC_PERSISTENT_FLAGS+=" ${ghcflag}"
				[[ ${assemble} ]] && ghcflag="-opta${flag}"  CFLAGS+=" ${flag}" && GHC_FLAGS+=" ${ghcflag}" &&
					[[ ${persistent} ]] && GHC_PERSISTENT_FLAGS+=" ${ghcflag}"
				[[ ${link}     ]] && ghcflag="-optl${flag}" LDFLAGS+=" ${flag}" && GHC_FLAGS+=" ${ghcflag}" &&
					[[ ${persistent} ]] && GHC_PERSISTENT_FLAGS+=" ${ghcflag}"
				;;
		esac
	done
}

ghc_setup_cflags() {
	if is_crosscompile; then
		export CFLAGS=${GHC_CFLAGS-"-O2 -pipe"}
		export LDFLAGS=${GHC_LDFLAGS-"-Wl,-O1"}
		einfo "Crosscompiling mode:"
		einfo "   CHOST:   ${CHOST}"
		einfo "   CTARGET: ${CTARGET}"
		einfo "   CFLAGS:  ${CFLAGS}"
		einfo "   LDFLAGS: ${LDFLAGS}"
		return
	fi
	# We need to be very careful with the CFLAGS we ask ghc to pass through to
	# gcc. There are plenty of flags which will make gcc produce output that
	# breaks ghc in various ways. The main ones we want to pass through are
	# -mcpu / -march flags. These are important for arches like alpha & sparc.
	# We also use these CFLAGS for building the C parts of ghc, ie the rts.
	strip-flags
	strip-unsupported-flags

	# Cmm can't parse line numbers #482086
	replace-flags -ggdb[3-9] -ggdb2

	GHC_FLAGS=""
	GHC_PERSISTENT_FLAGS=""
	for flag in ${CFLAGS}; do
		case ${flag} in

			# Ignore extra optimisation (ghc passes -O to gcc anyway)
			# -O2 and above break on too many systems
			-O*) ;;

			# Arch and ABI flags are what we're really after
			-m*) append-ghc-cflags compile assemble ${flag};;

			# Sometimes it's handy to see backtrace of RTS
			# to get an idea what happens there
			-g*) append-ghc-cflags compile ${flag};;

			# Ignore all other flags, including all -f* flags
		esac
	done

	for flag in ${LDFLAGS}; do
		append-ghc-cflags link ${flag}
	done

	# hardened-gcc needs to be disabled, because the mangler doesn't accept
	# its output.
	gcc-specs-pie && append-ghc-cflags persistent compile link -nopie
	gcc-specs-ssp && append-ghc-cflags persistent compile      -fno-stack-protector

	# prevent from failind building unregisterised ghc:
	# http://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg171602.html
	use ppc64 && append-ghc-cflags persistent compile -mminimal-toc
	# fix the similar issue as ppc64 TOC on ia64. ia64 has limited size of small data
	# currently ghc fails to build haddock
	# http://osdir.com/ml/gnu.binutils.bugs/2004-10/msg00050.html
	use ia64 && append-ghc-cflags persistent compile -G0 -Os
}

pkg_setup() {
	[[ -z $(type -P ghc) ]] && \
		die "Could not find a ghc to bootstrap with."
}

# as git-2_cleanup is too eager to cleanup
# variables where it stores repository in DISTDIR
# we override git-2_gc and do
git-2_gc() {
	debug-print-function ${FUNCNAME} "$@"

	local bargs="--branch=${EGIT_BRANCH}"
	local args=""
	if ! use dph; then
		args+=" --no-dph"
	fi

	pushd "${EGIT_DIR}" > /dev/null || die

	git config diff.ignoreSubmodules dirty \
		|| die 'git config --global diff.ignoreSubmodules dirty failed'

	set -- ./sync-all ${args} --testsuite get  ${bargs}
	einfo "$@"
	"$@"
	set -- ./sync-all ${args} --testsuite pull
	einfo "$@"
	"$@" || die

	popd > /dev/null
}

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		EGIT_NONBARE="true"
		EGIT_BRANCH="master"
		if [[ -n ${GHC_BRANCH} ]]; then
			EGIT_BRANCH="${GHC_BRANCH}"
		fi

		git-2_src_unpack
	else
		base_src_unpack
	fi
}

src_prepare() {
	ghc_setup_cflags

	sed -i -e "s|\"\$topdir\"|\"\$topdir\" ${GHC_FLAGS}|" \
		"${S}/ghc/ghc.wrapper"

	cd "${S}" # otherwise epatch will break

	epatch "${FILESDIR}/${P}-CHOST-prefix.patch"

	if ! use ghcmakebinary; then
		# one more external depend with unstable ABI be careful to stash it
		if [[ "${EGIT_BRANCH}" == "ghc-7.4" || ( -n ${GHC_USE_7_4_2_SYSTEM_LIBFFI_PATCH} ) ]]; then
			epatch "${FILESDIR}"/${PN}-7.4.2-system-libffi.patch
		else
			if [[ ${PV} == *7.7.20121213 ]]; then
				epatch "${FILESDIR}"/${PN}-7.7.20121213-system-libffi.patch
			fi
		fi
	fi

	if ! use dph ; then
		if [ -d "${S}"/libraries/dph ]; then
			rm -rf "${S}"/libraries/dph || die "Could not rm -rf ${S}/libraries/dph"
		fi
	fi

	sed -e 's@LIBFFI_CFLAGS="-I $withval"@LIBFFI_CFLAGS="-I$withval"@' \
		-i "${S}/configure.ac" \
		|| die "Could not remove space after -I from LIBFFI_CFLAGS in configure.ac and configure"

	if use prefix; then
		# Make configure find docbook-xsl-stylesheets from Prefix
		sed -e '/^FP_DIR_DOCBOOK_XSL/s:\[.*\]:['"${EPREFIX}"'/usr/share/sgml/docbook/xsl-stylesheets/]:' \
			-i utils/haddock/doc/configure.ac || die
	fi

	# TODO: remove this: if is_crosscompile.  This is a temporary workaround as
	# these cross patches no longer apply (upstream made lots of changes).
	if is_crosscompile; then
		# cross-only, but should be safe (might need some tweaks in build depends)
		cd "${S}/libraries/integer-gmp"
		epatch "${FILESDIR}"/${P}-integer-gmp-cross.patch
		cd "${S}/utils/hsc2hs"
		epatch "${FILESDIR}"/${P}-hsc2hs-cross.patch
		cd "${S}"
	fi

	# as we have changed the build system
	eautoreconf
}

src_configure() {
	local econf_args=()
	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# Put docs into the right place, ie /usr/share/doc/ghc-${PV}
	echo "docdir = ${EPREFIX}/usr/share/doc/${P}" >> mk/build.mk
	echo "htmldir = ${EPREFIX}/usr/share/doc/${P}" >> mk/build.mk

	# We can't depend on haddock except when bootstrapping when we
	# must build docs and include them into the binary .tbz2 package
	# app-text/dblatex is not in portage, can not build PDF or PS
	if use ghcbootstrap && use doc; then
		echo "BUILD_DOCBOOK_PDF  = NO"  >> mk/build.mk
		echo "BUILD_DOCBOOK_PS   = NO"  >> mk/build.mk
		echo "BUILD_DOCBOOK_HTML = YES" >> mk/build.mk
		if is_crosscompile; then
			# TODO this is a workaround for this build error with the live ebuild with haddock:
			# make[1]: *** No rule to make target `compiler/stage2/build/Module.hi',
			# needed by `utils/haddock/dist/build/Main.o'.  Stop.
			echo "HADDOCK_DOCS       = NO" >> mk/build.mk
		else
			echo "HADDOCK_DOCS       = YES" >> mk/build.mk
		fi
	else
		echo "BUILD_DOCBOOK_PDF  = NO" >> mk/build.mk
		echo "BUILD_DOCBOOK_PS   = NO" >> mk/build.mk
		echo "BUILD_DOCBOOK_HTML = NO" >> mk/build.mk
		echo "HADDOCK_DOCS       = NO" >> mk/build.mk
	fi

	# circumvent a very strange bug that seems related with ghc producing
	# too much output while being filtered through tee (e.g. due to
	# portage logging) reported as bug #111183
	echo "SRC_HC_OPTS+=-w" >> mk/build.mk

	# some arches do not support ELF parsing for ghci module loading
	# PPC64: never worked (should be easy to implement)
	# alpha: never worked
	# arm: http://hackage.haskell.org/trac/ghc/changeset/27302c9094909e04eb73f200d52d5e9370c34a8a
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

	# arm: no EvilMangler support, no NCG support
	if use arm; then
		echo "GhcUnregisterised=YES" >> mk/build.mk
		echo "GhcWithNativeCodeGen=NO" >> mk/build.mk
	fi

	# Have "ld -r --relax" problem with split-objs on sparc:
	if use sparc; then
		echo "SplitObjs=NO" >> mk/build.mk
	fi

	# might need additional fiddling with --host parameter:
	#    https://github.com/ghc/ghc/commit/109a1e53287f50103e8a5b592275940b6e3dbb53
	if is_crosscompile; then
		if [[ ${CHOST} != ${CTARGET} ]]; then
			echo "Stage1Only=YES" >> mk/build.mk
		fi
		# in registerised mode ghc is too keen to use llvm
		echo "GhcUnregisterised=YES" >> mk/build.mk
		# above is not enough to give up on llvm (x86_64 host, ia64 target)
		econf_args+=(--enable-unregisterised)
		# otherwise stage1 tries to run nonexistent ghc-split.lprl
		echo "SplitObjs=NO" >> mk/build.mk
	fi

	# allows overriding build flavours for libraries:
	# v   - vanilla (static libs)
	# p   - profiled
	# dyn - shared libraries
	# example: GHC_LIBRARY_WAYS="v dyn"
	if [[ -n ${GHC_LIBRARY_WAYS} ]]; then
		echo "GhcLibWays=${GHC_LIBRARY_WAYS}" >> mk/build.mk
	fi

	if use gmp; then
		echo "INTEGER_LIBRARY=integer-gmp" >> mk/build.mk
	else
		echo "INTEGER_LIBRARY=integer-simple" >> mk/build.mk
	fi

	# We also need to use the GHC_FLAGS flags when building ghc itself
	echo "SRC_HC_OPTS+=${GHC_FLAGS}" >> mk/build.mk
	echo "SRC_CC_OPTS+=${CFLAGS}" >> mk/build.mk
	echo "SRC_LD_OPTS+=${FILTERED_LDFLAGS}" >> mk/build.mk

	# This is only for head builds
	perl boot || die "perl boot failed"

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

	is_crosscompile || econf_args+=(--with-gcc=${CHOST}-gcc)
	if ! use ghcmakebinary; then
		econf_args+=(--with-system-libffi)
		econf_args+=(--with-ffi-includes=$(pkg-config libffi --cflags-only-I | sed -e 's@^-I@@'))
	fi

	econf ${econf_args[@]} --enable-bootstrap-with-devel-snapshot

	GHC_PV="$(grep 'S\[\"PACKAGE_VERSION\"\]' config.status | sed -e 's@^.*=\"\(.*\)\"@\1@')"
	GHC_TPF="$(grep 'S\[\"TargetPlatformFull\"\]' config.status | sed -e 's@^.*=\"\(.*\)\"@\1@')"
}

src_compile() {
	#limit_jobs() {
	#	if [[ -n ${I_DEMAND_MY_CORES_LOADED} ]]; then
	#		ewarn "You have requested parallel build which is known to break."
	#		ewarn "Please report all breakages upstream."
	#		return
	#	fi
	#	echo $@
	#}
	# ghc massively parallel make: #409631, #409873
	#   but let users screw it by setting 'I_DEMAND_MY_CORES_LOADED'
	#emake $(limit_jobs -j1) all
	# ^ above seems to be fixed.
	(
		unset ABI # bundled gmp uses ABI on it's own
		emake all
	) || die
}

src_install() {
	local insttarget="install"

	emake -j1 ${insttarget} \
		DESTDIR="${D}" \
		|| die "make ${insttarget} failed"

	# remove wrapper and linker
	rm -f "${ED}"/usr/bin/haddock*

	# ghci uses mmap with rwx protection at it implements dynamic
	# linking on it's own (bug #299709)
	# so mark resulting binary
	pax-mark -m "${ED}/usr/$(get_libdir)/${PN}-${GHC_PV}/ghc"

	if [[ ! -f "${S}/VERSION" ]]; then
		echo "${GHC_PV}" > "${S}/VERSION" \
			|| die "Could not create file ${S}/VERSION"
	fi
	if [[ "${PV}" == "7.7.20130809" ]]; then
		dodoc "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"
	else
		dodoc "${S}/README.md" "${S}/ANNOUNCE" "${S}/LICENSE" "${S}/VERSION"
	fi

	dobashcomp "${FILESDIR}/ghc-bash-completion"

	# path to the package.conf.d
	local package_confdir="${ED}/usr/$(get_libdir)/${PN}-${GHC_PV}/package.conf.d"
	# path to the package.cache
	PKGCACHE="${ED}/usr/$(get_libdir)/${PN}-${GHC_PV}/package.conf.d/package.cache"
	# copy the package.conf.d, including timestamp, save it so we can help
	# users that have a broken package.conf.d
	cp -pR "${package_confdir}"{,.initial} || die "failed to backup intial package.conf.d"

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
	PKGCACHE="${EROOT}/usr/$(get_libdir)/${PN}-${GHC_PV}/package.conf.d/package.cache"

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
	fi
	if is_crosscompile; then
		ewarn
		ewarn "GHC built as a cross compiler.  The interpreter, ghci and runghc, do"
		ewarn "not work for a cross compiler."
		ewarn "For the ghci error: \"<command line>: not built for interactive use\" see:"
		ewarn "http://www.haskell.org/haskellwiki/GHC:FAQ#When_I_try_to_start_ghci_.28probably_one_I_compiled_myself.29_it_says_ghc-5.02:_not_built_for_interactive_use"
	fi
	ewarn
	ewarn "\e[1;31m************************************************************************\e[0m"
	ewarn
}

pkg_prerm() {
	# Be very careful here... Call order when upgrading is (according to PMS):
	# * src_install for new package
	# * pkg_preinst for new package
	# * pkg_postinst for new package
	# * pkg_prerm for the package being replaced
	# * pkg_postrm for the package being replaced
	# so you'll actually be touching the new packages files, not the one you
	# uninstall, due to that or installation directory ${PN}-${GHC_PV} will be the same for
	# both packages.

	# Call order for reinstalling is (according to PMS):
	# * src_install
	# * pkg_preinst
	# * pkg_prerm for the package being replaced
	# * pkg_postrm for the package being replaced
	# * pkg_postinst

	# Overwrite the modified package.cache with a copy of the
	# original one, so that it will be removed during uninstall.

	PKGCACHE="${EROOT}/usr/$(get_libdir)/${PN}-${GHC_PV}/package.conf.d/package.cache"
	rm -rf "${PKGCACHE}"

	cp -p "${PKGCACHE}"{.shipped,}
}

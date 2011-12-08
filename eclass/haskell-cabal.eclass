# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/haskell-cabal.eclass,v 1.20 2010/03/30 22:18:37 kolmodin Exp $
#
# Original authors: Andres Loeh <kosmikus@gentoo.org>
#                   Duncan Coutts <dcoutts@gentoo.org>
# Maintained by: Haskell herd <haskell@gentoo.org>
#
# This eclass is for packages that make use of the
# Haskell Common Architecture for Building Applications
# and Libraries (cabal).
#
# Basic instructions:
#
# Before inheriting the eclass, set CABAL_FEATURES to
# reflect the tools and features that the package makes
# use of.
#
# Currently supported features:
#   haddock    --  for documentation generation
#   hscolour   --  generation of colourised sources
#   hoogle     --  generation of documentation search index
#   alex       --  lexer/scanner generator
#   happy      --  parser generator
#   c2hs       --  C interface generator
#   cpphs      --  C preprocessor clone written in Haskell
#   profile    --  if package supports to build profiling-enabled libraries
#   bootstrap  --  only used for the cabal package itself
#   bin        --  the package installs binaries
#   lib        --  the package installs libraries
#   nocabaldep --  don't add dependency on cabal.
#                  only used for packages that _must_ not pull the dependency
#                  on cabal, but still use this eclass (e.g. haskell-updater).
#
# Dependencies on other cabal packages have to be specified
# correctly.
#
# Cabal libraries should usually be SLOTted with "${PV}".
#
# Many Cabal packages require S to be manually set.
#
# Conforming Cabal packages don't require any function definitions
# in the ebuild.
#
# Special flags to Cabal Configure can now be set by using
# CABAL_CONFIGURE_FLAGS

inherit ghc-package multilib

# @ECLASS-VARIABLE: CABAL_EXTRA_CONFIGURE_FLAGS
# @DESCRIPTION:
# User-specified additional parameters passed to 'setup configure'.
# example: /etc/make.conf: CABAL_EXTRA_CONFIGURE_FLAGS=--enable-shared
: ${CABAL_EXTRA_CONFIGURE_FLAGS:=}

# @ECLASS-VARIABLE: GHC_BOOTSTRAP_FLAGS
# @DESCRIPTION:
# User-specified additional parameters for ghc when building
# _only_ 'setup' binary bootstrap.
# example: /etc/make.conf: GHC_BOOTSTRAP_FLAGS=-dynamic to make
# linking 'setup' faster.
: ${GHC_BOOTSTRAP_FLAGS:=}

HASKELL_CABAL_EXPF="pkg_setup src_compile src_test src_install"

case "${EAPI:-0}" in
	2|3|4) HASKELL_CABAL_EXPF+=" src_configure" ;;
	*) ;;
esac

EXPORT_FUNCTIONS ${HASKELL_CABAL_EXPF}

for feature in ${CABAL_FEATURES}; do
	case ${feature} in
		haddock)    CABAL_USE_HADDOCK=yes;;
		hscolour)   CABAL_USE_HSCOLOUR=yes;;
		hoogle)     CABAL_USE_HOOGLE=yes;;
		alex)       CABAL_USE_ALEX=yes;;
		happy)      CABAL_USE_HAPPY=yes;;
		c2hs)       CABAL_USE_C2HS=yes;;
		cpphs)      CABAL_USE_CPPHS=yes;;
		profile)    CABAL_USE_PROFILE=yes;;
		bootstrap)  CABAL_BOOTSTRAP=yes;;
		bin)        CABAL_HAS_BINARIES=yes;;
		lib)        CABAL_HAS_LIBRARIES=yes;;
		nocabaldep) CABAL_FROM_GHC=yes;;
		*) CABAL_UNKNOWN="${CABAL_UNKNOWN} ${feature}";;
	esac
done

if [[ -n "${CABAL_USE_HADDOCK}" ]]; then
	IUSE="${IUSE} doc"
	DEPEND="${DEPEND} doc? ( dev-haskell/haddock )"
fi

if [[ -n "${CABAL_USE_HSCOLOUR}" ]]; then
	IUSE="${IUSE} hscolour"
	DEPEND="${DEPEND} hscolour? ( dev-haskell/hscolour )"
fi

if [[ -n "${CABAL_USE_HOOGLE}" ]]; then
	IUSE="${IUSE} hoogle"
	DEPEND="${DEPEND} hoogle? ( dev-haskell/hoogle )"
fi

if [[ -n "${CABAL_USE_ALEX}" ]]; then
	DEPEND="${DEPEND} dev-haskell/alex"
fi

if [[ -n "${CABAL_USE_HAPPY}" ]]; then
	DEPEND="${DEPEND} dev-haskell/happy"
fi

if [[ -n "${CABAL_USE_C2HS}" ]]; then
	DEPEND="${DEPEND} dev-haskell/c2hs"
fi

if [[ -n "${CABAL_USE_CPPHS}" ]]; then
	DEPEND="${DEPEND} dev-haskell/cpphs"
fi

if [[ -n "${CABAL_USE_PROFILE}" ]]; then
	IUSE="${IUSE} profile"
fi

# We always use a standalone version of Cabal, rather than the one that comes
# with GHC. But of course we can't depend on cabal when building cabal itself.
if [[ -z ${CABAL_MIN_VERSION} ]]; then
	CABAL_MIN_VERSION=1.1.4
fi
if [[ -z "${CABAL_BOOTSTRAP}" && -z "${CABAL_FROM_GHC}" ]]; then
	DEPEND="${DEPEND} >=dev-haskell/cabal-${CABAL_MIN_VERSION}"
fi

# Libraries require GHC to be installed.
if [[ -n "${CABAL_HAS_LIBRARIES}" ]]; then
	RDEPEND="${RDEPEND} dev-lang/ghc"
fi

# returns the version of cabal currently in use
_CABAL_VERSION_CACHE=""
cabal-version() {
	if [[ -z "${_CABAL_VERSION_CACHE}" ]]; then
		if [[ "${CABAL_BOOTSTRAP}" ]]; then
			# We're bootstrapping cabal, so the cabal version is the version
			# of this package itself.
			_CABAL_VERSION_CACHE="${PV}"
		elif [[ "${CABAL_FROM_GHC}" ]]; then
			local cabal_package=$(echo "$(ghc-libdir)"/Cabal-*)
			# /path/to/ghc/Cabal-${VER} -> ${VER}
			_CABAL_VERSION_CACHE="${cabal_package/*Cabal-/}"
		else
			# We ask portage, not ghc, so that we only pick up
			# portage-installed cabal versions.
			_CABAL_VERSION_CACHE="$(ghc-extractportageversion dev-haskell/cabal)"
		fi
	fi
	echo "${_CABAL_VERSION_CACHE}"
}

cabal-bootstrap() {
	local setupmodule
	local cabalpackage
	if [[ -f "${S}/Setup.lhs" ]]; then
		setupmodule="${S}/Setup.lhs"
	else
		if [[ -f "${S}/Setup.hs" ]]; then
			setupmodule="${S}/Setup.hs"
		else
			die "No Setup.lhs or Setup.hs found"
		fi
	fi

	# We build the setup program using the latest version of
	# cabal that we have installed
	if version_is_at_least "6.4" "$(ghc-version)"; then
		cabalpackage=Cabal-$(cabal-version)
	else
		# older ghc's don't support package versioning
		cabalpackage=Cabal
	fi
	einfo "Using cabal-$(cabal-version)."

	make_setup() {
		set -- -package "${cabalpackage}" --make "${setupmodule}" \
			${GHC_BOOTSTRAP_FLAGS} \
			"$@" \
			-o setup
		echo $(ghc-getghc) "$@"
		$(ghc-getghc) "$@"
	}
	if $(ghc-supports-shared-libraries); then
		# some custom build systems might use external libraries,
		# for which we don't have shared libs, so keep static fallback
		make_setup -dynamic "$@" || make_setup "$@" || die "compiling ${setupmodule} failed"
	else
		make_setup "$@" || die "compiling ${setupmodule} failed"
	fi
}

cabal-mksetup() {
	local setupdir

	if [[ -n $1 ]]; then
		setupdir=$1
	else
		setupdir=${S}
	fi

	rm -f "${setupdir}"/Setup.{lhs,hs}

	echo 'import Distribution.Simple; main = defaultMainWithHooks defaultUserHooks' \
		> $setupdir/Setup.hs
}

cabal-hoogle-convert() {
	cabalfile=$(ls --format=single-column *.cabal | head -n1)
	if [[ -f "${S}/${cabalfile}" ]]; then
		cabalpkgname=${cabalfile:0:$(expr index ${cabalfile} ".")-1}
		hoogletxt="${S}/dist/doc/html/${cabalpkgname}/${cabalpkgname}.txt"
		hooglehoo="${S}/dist/doc/html/${cabalpkgname}/${cabalpkgname}.hoo"
		if [[ -f ${hoogletxt} ]]; then
			set -- convert ${hoogletxt} ${hooglehoo} "$@"
			echo hoogle "$@"
			hoogle "$@"
		fi
	fi
}

cabal-hscolour() {
	set -- hscolour "$@"
	echo ./setup "$@"
	./setup "$@" || die "setup hscolour failed"
}

cabal-haddock() {
	set -- haddock "$@"
	echo ./setup "$@"
	./setup "$@" || die "setup haddock failed"
}

cabal-hoogle() {
	ewarn "hoogle USE flag requires doc USE flag, building with haddock and hoogle"
	cabal-hoogle-haddock
}

cabal-hscolour-haddock() {
	# --hyperlink-source implies calling 'setup hscolour'
	set -- haddock --hyperlink-source
	echo ./setup "$@"
	./setup "$@" --hyperlink-source || die "setup haddock --hyperlink-source failed"
}

cabal-hoogle-haddock() {
	set -- haddock --hoogle
	echo ./setup "$@"
	./setup "$@" || die "setup haddock --hoogle failed"
	cabal-hoogle-convert
}

cabal-hoogle-hscolour-haddock() {
	cabal-hscolour-haddock
	cabal-hoogle-haddock
}

cabal-hoogle-hscolour() {
	ewarn "hoogle USE flag requires doc USE flag, building with haddock, hoogle and hscolour"
	cabal-hoogle-hscolour-haddock
}

cabal-configure() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=

	if [[ -n "${CABAL_USE_HADDOCK}" ]] && use doc; then
		cabalconf="${cabalconf} --with-haddock=${EPREFIX}/usr/bin/haddock"
	fi
	if [[ -n "${CABAL_USE_PROFILE}" ]] && use profile; then
		cabalconf="${cabalconf} --enable-library-profiling"
	fi
	if [[ -n "${CABAL_USE_ALEX}" ]]; then
		cabalconf="${cabalconf} --with-alex=${EPREFIX}/usr/bin/alex"
	fi

	if [[ -n "${CABAL_USE_HAPPY}" ]]; then
		cabalconf="${cabalconf} --with-happy=${EPREFIX}/usr/bin/happy"
	fi

	if [[ -n "${CABAL_USE_C2HS}" ]]; then
		cabalconf="${cabalconf} --with-c2hs=${EPREFIX}/usr/bin/c2hs"
	fi
	if [[ -n "${CABAL_USE_CPPHS}" ]]; then
		cabalconf="${cabalconf} --with-cpphs=${EPREFIX}/usr/bin/cpphs"
	fi

	# Building GHCi libs on ppc64 causes "TOC overflow".
	if use ppc64; then
		cabalconf="${cabalconf} --disable-library-for-ghci"
	fi

	# currently cabal does not respect CFLAGS and LDFLAGS on it's own (bug #333217)
	# so translate LDFLAGS to ghc parameters (without filtering)
	local flag
	for flag in $LDFLAGS; do cabalconf="${cabalconf} --ghc-option=-optl$flag"; done

	if version_is_at_least "1.4" "$(cabal-version)"; then
		# disable executable stripping for the executables, as portage will
		# strip by itself, and pre-stripping gives a QA warning.
		# cabal versions previous to 1.4 does not strip executables, and does
		# not accept the flag.
		# this fixes numerous bugs, amongst them;
		# bug #251881, bug #251882, bug #251884, bug #251886, bug #299494
		cabalconf="${cabalconf} --disable-executable-stripping"
	fi

	if version_is_at_least "1.2.0" "$(cabal-version)"; then
		cabalconf="${cabalconf} --docdir=${EPREFIX}/usr/share/doc/${PF}"
		# As of Cabal 1.2, configure is quite quiet. For diagnostic purposes
		# it's better if the configure chatter is in the build logs:
		cabalconf="${cabalconf} --verbose"
	fi
	# Note: with Cabal-1.1.6.x we do not have enough control
	# to put the docs into the right place. They're currently going
	# into			/usr/share/${P}/ghc-x.y/doc/
	# rather than	/usr/share/doc/${PF}/
	# Because we can only set the datadir, not the docdir.

	# We build shared version of our Cabal where ghc ships it's shared
	# version of it. We will link ./setup as dynamic binary againt Cabal later.
	[[ ${CATEGORY}/${PN} == "dev-haskell/cabal" ]] && \
		$(ghc-supports-shared-libraries) && \
			cabalconf="${cabalconf} --enable-shared"

	set -- configure \
		--ghc --prefix="${EPREFIX}"/usr \
		--with-compiler="$(ghc-getghc)" \
		--with-hc-pkg="$(ghc-getghcpkg)" \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--libsubdir=${P}/ghc-$(ghc-version) \
		--datadir="${EPREFIX}"/usr/share/ \
		--datasubdir=${P}/ghc-$(ghc-version) \
		${cabalconf} \
		${CABAL_CONFIGURE_FLAGS} \
		${CABAL_EXTRA_CONFIGURE_FLAGS} \
		"$@"
	echo ./setup "$@"
	./setup "$@" || die "setup configure failed"
}

cabal-build() {
	unset LANG LC_ALL LC_MESSAGES
	set --  build "$@"
	echo ./setup "$@"
	./setup build \
		|| die "setup build failed"
}

cabal-copy() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && ED=${D}

	set -- copy --destdir="${D}" "$@"
	echo ./setup "$@"
	./setup "$@" || die "setup copy failed"

	# cabal is a bit eager about creating dirs,
	# so remove them if they are empty
	rmdir "${ED}/usr/bin" 2> /dev/null

	# GHC 6.4 has a bug in get/setPermission and Cabal 1.1.1 has
	# no workaround.
	# set the +x permission on executables
	if [[ -d "${ED}/usr/bin" ]] ; then
		chmod +x "${ED}/usr/bin/"*
	fi
	# TODO: do we still need this?
}

cabal-pkg() {
	# This does not actually register since we're using true instead
	# of ghc-pkg. So it just leaves the .installed-pkg-config and we can
	# register that ourselves (if it exists).
	local result
	local err

	if [[ -n ${CABAL_HAS_LIBRARIES} ]]; then
		if version_is_at_least "1.2.0" "$(cabal-version)"; then
			# Newer cabal can generate a package conf for us:
			./setup register --gen-pkg-config="${T}/${P}.conf"
			ghc-setup-pkg "${T}/${P}.conf"
			ghc-install-pkg
		else
			# With older cabal we have to hack it by replacing its ghc-pkg
			# with true and then just picking up the .installed-pkg-config
			# file and registering that ourselves (if it exists).
			sed -i "s|$(ghc-getghcpkg)|$(type -P true)|" .setup-config
			./setup register || die "setup register failed"
			if [[ -f .installed-pkg-config ]]; then
				ghc-setup-pkg .installed-pkg-config
				ghc-install-pkg
			else
				die "setup register has not generated a package configuration file"
			fi
		fi
	fi
}

# Some cabal libs are bundled along with some versions of ghc
# eg filepath-1.0 comes with ghc-6.6.1
# by putting CABAL_CORE_LIB_GHC_PV="6.6.1" in an ebuild we are declaring that
# when building with this version of ghc, the ebuild is a dummy that is it will
# install no files since the package is already included with ghc.
# However portage still records the dependency and we can upgrade the package
# to a later one that's not included with ghc.
# You can also put a space separated list, eg CABAL_CORE_LIB_GHC_PV="6.6 6.6.1".
cabal-is-dummy-lib() {
	for version in ${CABAL_CORE_LIB_GHC_PV[*]}; do
		[[ "$(ghc-version)" == "$version" ]] && return 0
	done
	return 1
}

# exported function: check if cabal is correctly installed for
# the currently active ghc (we cannot guarantee this with portage)
haskell-cabal_pkg_setup() {
	ghc-package_pkg_setup
	if [[ -z "${CABAL_BOOTSTRAP}" && -z "${CABAL_FROM_GHC}" ]] && ! ghc-sanecabal "${CABAL_MIN_VERSION}"; then
		eerror "The package dev-haskell/cabal is not correctly installed for"
		eerror "the currently active version of ghc ($(ghc-version)). Please"
		eerror "run ghc-updater or haskell-updater or re-build dev-haskell/cabal."
		die "cabal is not correctly installed"
	fi
	if [[ -z "${CABAL_HAS_BINARIES}" ]] && [[ -z "${CABAL_HAS_LIBRARIES}" ]]; then
		eerror "QA: Neither bin nor lib are in CABAL_FEATURES."
	fi
	if [[ -n "${CABAL_UNKNOWN}" ]]; then
		ewarn "Unknown entry in CABAL_FEATURES: ${CABAL_UNKNOWN}"
	fi
	if cabal-is-dummy-lib; then
		einfo "${P} is included in ghc-${CABAL_CORE_LIB_GHC_PV}, nothing to install."
	fi
}

haskell-cabal_src_configure() {
	if ! cabal-is-dummy-lib; then
		pushd "${S}" > /dev/null

		cabal-bootstrap

		cabal-configure $ghc_flags "$@"

		popd > /dev/null
	fi
}

# exported function: nice alias
cabal_src_configure() {
	haskell-cabal_src_configure "$@"
}

# exported function: cabal-style bootstrap configure and compile
cabal_src_compile() {
	# it's a common mistake when one bumps ebuild to EAPI="2" (and upper)
	# and forgets to separate src_compile() to src_configure()/src_compile().
	# Such error leads to default src_configure and we lose all passed flags.
	if ! has "${EAPI:-0}" 0 1; then
		local passed_flag
		for passed_flag in "$@"; do
			[[ ${passed_flag} == --flags=* ]] && \
				eqawarn "Cabal option '${passed_flag}' has effect only in src_configure()"
		done
	fi

	if ! cabal-is-dummy-lib; then
		has src_configure ${HASKELL_CABAL_EXPF} || haskell-cabal_src_configure "$@"
		cabal-build

		if [[ -n "${CABAL_USE_HADDOCK}" ]] && use doc; then
			if [[ -n "${CABAL_USE_HSCOLOUR}" ]] && use hscolour; then
				if [[ -n "${CABAL_USE_HOOGLE}" ]] && use hoogle; then
					# hoogle, hscolour and haddock
					cabal-hoogle-hscolour-haddock
				else
					# haddock and hscolour
					cabal-hscolour-haddock
				fi
			else
				if [[ -n "${CABAL_USE_HOOGLE}" ]] && use hoogle; then
					# hoogle and haddock
					cabal-hoogle-haddock
				else
					# just haddock
					cabal-haddock
				fi
			fi
		else
			if [[ -n "${CABAL_USE_HSCOLOUR}" ]] && use hscolour; then
				if [[ -n "${CABAL_USE_HOOGLE}" ]] && use hoogle; then
					# hoogle and hscolour
					cabal-hoogle-hscolour
				else
					# just hscolour
					cabal-hscolour
				fi
			else
				if [[ -n "${CABAL_USE_HOOGLE}" ]] && use hoogle; then
					# just hoogle
					cabal-hoogle
				fi
			fi
		fi
	fi
}

haskell-cabal_src_compile() {
	pushd "${S}" > /dev/null

	cabal_src_compile "$@"

	popd > /dev/null
}

haskell-cabal_src_test() {
	pushd "${S}" > /dev/null

	if cabal-is-dummy-lib; then
		einfo ">>> No tests for dummy library: ${CATEGORY}/${PF}"
	else
		einfo ">>> Test phase [cabal test]: ${CATEGORY}/${PF}"
		set -- test "$@"
		echo ./setup "$@"
		./setup "$@" || die "cabal test failed"
	fi

	popd > /dev/null
}

# exported function: cabal-style copy and register
cabal_src_install() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=

	if cabal-is-dummy-lib; then
		# create a dummy local package conf file for the sake of ghc-updater
		local ghc_confdir_with_prefix="$(ghc-confdir)"
		# remove EPREFIX
		dodir ${ghc_confdir_with_prefix#${EPREFIX}}
		echo '[]' > "${D}/$(ghc-confdir)/$(ghc-localpkgconf)"
	else
		cabal-copy
		cabal-pkg

		if [[ -n "${CABAL_USE_HADDOCK}" ]] && use doc; then
			if ! version_is_at_least "1.1.6" "$(cabal-version)"; then
				dohtml -r dist/doc/html/*
			fi
		fi
	fi
}

haskell-cabal_src_install() {
	pushd "${S}" > /dev/null

	cabal_src_install

	popd > /dev/null
}

# ebuild.sh:use_enable() taken as base
#
# Usage examples:
#
#     CABAL_CONFIGURE_FLAGS=$(cabal_flag gui)
#  leads to "--flags=gui" or "--flags=-gui" (useflag 'gui')
#
#     CABAL_CONFIGURE_FLAGS=$(cabal_flag gtk gui)
#  also leads to "--flags=gui" or " --flags=-gui" (useflag 'gtk')
#
cabal_flag() {
	if [[ -z "$1" ]]; then
		echo "!!! cabal_flag() called without a parameter." >&2
		echo "!!! cabal_flag() <USEFLAG> [<cabal_flagname>]" >&2
		return 1
	fi

	local UWORD=${2:-$1}

	if use "$1"; then
		echo "--flags=${UWORD}"
	else
		echo "--flags=-${UWORD}"
	fi

	return 0
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/haskell-cabal.eclass,v 1.14 2007/12/13 04:44:39 dcoutts Exp $
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
#   alex       --  lexer/scanner generator
#   happy      --  parser generator
#   c2hs       --  C interface generator
#   cpphs      --  C preprocessor clone written in Haskell
#   profile    --  if package supports to build profiling-enabled libraries
#   bootstrap  --  only used for the cabal package itself
#   bin        --  the package installs binaries
#   lib        --  the package installs libraries
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


for feature in ${CABAL_FEATURES}; do
	case ${feature} in
		haddock)   CABAL_USE_HADDOCK=yes;;
		alex)      CABAL_USE_ALEX=yes;;
		happy)     CABAL_USE_HAPPY=yes;;
		c2hs)      CABAL_USE_C2HS=yes;;
		cpphs)     CABAL_USE_CPPHS=yes;;
		profile)   CABAL_USE_PROFILE=yes;;
		bootstrap) CABAL_BOOTSTRAP=yes;;
		bin)       CABAL_HAS_BINARIES=yes;;
		lib)       CABAL_HAS_LIBRARIES=yes;;
		*) CABAL_UNKNOWN="${CABAL_UNKNOWN} ${feature}";;
	esac
done

if [[ -n "${CABAL_USE_HADDOCK}" ]]; then
	IUSE="${IUSE} doc"
	DEPEND="${DEPEND} doc? ( dev-haskell/haddock )"
fi

if [[ -n "${CABAL_USE_ALEX}" ]]; then
	DEPEND="${DEPEND} dev-haskell/alex"
	cabalconf="${cabalconf} --with-alex=/usr/bin/alex"
fi

if [[ -n "${CABAL_USE_HAPPY}" ]]; then
	DEPEND="${DEPEND} dev-haskell/happy"
	cabalconf="${cabalconf} --with-happy=/usr/bin/happy"
fi

if [[ -n "${CABAL_USE_C2HS}" ]]; then
	DEPEND="${DEPEND} dev-haskell/c2hs"
	cabalconf="${cabalconf} --with-c2hs=/usr/bin/c2hs"
fi

if [[ -n "${CABAL_USE_CPPHS}" ]]; then
	DEPEND="${DEPEND} dev-haskell/cpphs"
	cabalconf="${cabalconf} --with-cpphs=/usr/bin/cpphs"
fi

if [[ -n "${CABAL_USE_PROFILE}" ]]; then
	IUSE="${IUSE} profile"
fi

# We always use a standalone version of Cabal, rather than the one that comes
# with GHC. But of course we can't depend on cabal when building cabal itself.
if [[ -z ${CABAL_MIN_VERSION} ]]; then
	CABAL_MIN_VERSION=1.1.4
fi
if [[ -z "${CABAL_BOOTSTRAP}" ]]; then
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
	$(ghc-getghc) -package "${cabalpackage}" --make "${setupmodule}" -o setup \
		|| die "compiling ${setupmodule} failed"
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

cabal-haddock() {
	./setup haddock || die "setup haddock failed"
}

cabal-configure() {
	if [[ -n "${CABAL_USE_HADDOCK}" ]] && use doc; then
		cabalconf="${cabalconf} --with-haddock=/usr/bin/haddock"
	fi
	if [[ -n "${CABAL_USE_PROFILE}" ]] && use profile; then
		cabalconf="${cabalconf} --enable-library-profiling"
	fi
	# Building GHCi libs on ppc64 causes "TOC overflow".
	if use ppc64; then
		cabalconf="${cabalconf} --disable-library-for-ghci"
	fi

	if version_is_at_least "1.2.0" "$(cabal-version)"; then
		cabalconf="${cabalconf} --docdir=/usr/share/doc/${PF}"
		# As of Cabal 1.2, configure is quite quiet. For diagnostic purposes
		# it's better if the configure chatter is in the build logs:
		cabalconf="${cabalconf} --verbose"
	fi
	# Note: with Cabal-1.1.6.x we do not have enough control
	# to put the docs into the right place. They're currently going
	# into			/usr/share/${P}/ghc-x.y/doc/
	# rather than	/usr/share/doc/${PF}/
	# Because we can only set the datadir, not the docdir.

	./setup configure \
		--ghc --prefix=/usr \
		--with-compiler="$(ghc-getghc)" \
		--with-hc-pkg="$(ghc-getghcpkg)" \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--libsubdir=${P}/ghc-$(ghc-version) \
		--datadir=/usr/share/ \
		--datasubdir=${P}/ghc-$(ghc-version) \
		${cabalconf} \
		${CABAL_CONFIGURE_FLAGS} \
		"$@" || die "setup configure failed"
}

cabal-build() {
	unset LANG LC_ALL LC_MESSAGES
	./setup build \
		|| die "setup build failed"
}

cabal-copy() {
	./setup copy \
		--destdir="${D}" \
		|| die "setup copy failed"

	# cabal is a bit eager about creating dirs,
	# so remove them if they are empty
	rmdir "${D}/usr/bin" 2> /dev/null

	# GHC 6.4 has a bug in get/setPermission and Cabal 1.1.1 has
	# no workaround.
	# set the +x permission on executables
	if [[ -d "${D}/usr/bin" ]] ; then
		chmod +x "${D}/usr/bin/"*
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
	if [[ -z "${CABAL_BOOTSTRAP}" ]] && ! ghc-sanecabal "${CABAL_MIN_VERSION}"; then
		eerror "The package dev-haskell/cabal is not correctly installed for"
		eerror "the currently active version of ghc ($(ghc-version)). Please"
		eerror "run ghc-updater or re-emerge dev-haskell/cabal."
		die "cabal is not correctly installed"
	fi
	if [[ -z "${CABAL_HAS_BINARIES}" ]] && [[ -z "${CABAL_HAS_LIBRARIES}" ]]; then
		eerror "QA: Neither bin nor lib are in CABAL_FEATURES."
	fi
	if [[ -n "${CABAL_UNKNOWN}" ]]; then
		ewarn "Unknown entry in CABAL_FEATURES: ${CABAL_UNKNONW}"
	fi
	if cabal-is-dummy-lib; then
		einfo "${P} is included in ghc-${CABAL_CORE_LIB_GHC_PV}, nothing to install."
	fi
}

# exported function: cabal-style bootstrap configure and compile
cabal_src_compile() {
	if ! cabal-is-dummy-lib; then
		cabal-bootstrap
		cabal-configure
		cabal-build

		if [[ -n "${CABAL_USE_HADDOCK}" ]] && use doc; then
			cabal-haddock
		fi
	fi
}
haskell-cabal_src_compile() {
	cabal_src_compile
}

# exported function: cabal-style copy and register
cabal_src_install() {
	if cabal-is-dummy-lib; then
		# create a dummy local package conf file for the sake of ghc-updater
		dodir "$(ghc-confdir)"
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
	cabal_src_install
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install

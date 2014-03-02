# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bootstrap lib profile test-suite"
inherit haskell-cabal versionator

MY_PN="Cabal"
MY_PV=$(get_version_component_range '1-4')
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${MY_P}_pre20140130.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-lang/ghc-6.12.1:="
DEPEND="${RDEPEND}
	test? ( dev-haskell/extensible-exceptions
		dev-haskell/hunit
		>=dev-haskell/quickcheck-2.1.0.1
		dev-haskell/regex-posix
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		>=dev-haskell/test-framework-quickcheck2-0.2.12 )
"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

CABAL_CORE_LIB_GHC_PV="7.8.2014* 7.8.0.2014*"

src_prepare() {
	if [[ -n ${LIVE_EBUILD} ]]; then
		CABAL_FILE=${MY_PN}.cabal cabal_chdeps 'version: 1.17.0' "version: ${PV}"
	fi
}

src_configure() {
	cabal-is-dummy-lib && return

	einfo "Bootstrapping Cabal..."
	$(ghc-getghc) ${HCFLAGS} -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
		-o setup || die "compiling Setup.hs failed"
	cabal-configure
}

src_compile() {
	cabal-is-dummy-lib && return

	cabal-build
}

pkg_postinst() {
	ghc-package_pkg_postinst
	ewarn
	ewarn "\e[1;31m************************************************************************\e[0m"
	ewarn
	ewarn "This is *NOT* cabal-1.18.1.3 - it is just an evil snapshot from ghc 7.8.1_rc1."
	ewarn "You may at some later date when the real cabal-1.18.1.3 is released emerge it"
	ewarn "again to to purge this abomination from your system!"
	ewarn
	ewarn "\e[1;31m************************************************************************\e[0m"
	ewarn
}

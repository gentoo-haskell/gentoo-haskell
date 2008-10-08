# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bootstrap profile lib"
inherit haskell-cabal eutils

GHC_PV=6.10.0.20081007

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/filepath"

CABAL_CORE_LIB_GHC_PV="${GHC_PV}"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"

src_compile() {
	if ! cabal-is-dummy-lib; then
		$(ghc-getghc) --make -o setup Setup.hs
		cabal-configure
		cabal-build
	fi
}

src_install() {
	cabal_src_install

	dodoc LICENSE
}

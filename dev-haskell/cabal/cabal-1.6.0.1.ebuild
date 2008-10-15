# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bootstrap lib profile"
inherit haskell-cabal eutils

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/filepath"

S="${WORKDIR}/${MY_P}"

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

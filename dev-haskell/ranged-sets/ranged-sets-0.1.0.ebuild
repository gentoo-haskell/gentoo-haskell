# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="Ranged-sets"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Ranged sets for Haskell"
HOMEPAGE="http://ranged-sets.sourceforge.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	sed -i -e 's/Build-Depends:  base/Build-Depends: base, QuickCheck/' \
		"${S}/Ranged-sets.cabal"
}

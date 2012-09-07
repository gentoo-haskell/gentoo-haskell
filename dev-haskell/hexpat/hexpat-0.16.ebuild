# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="XML parser/formatter based on expat"
HOMEPAGE="http://haskell.org/haskellwiki/Hexpat/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EXTRALIBS="dev-libs/expat"
HASKELLDEPS=">=dev-haskell/list-0.4
		dev-haskell/parallel:2
		>=dev-haskell/text-0.5
		dev-haskell/transformers
		>=dev-haskell/utf8-string-0.3.3"
RDEPEND=">=dev-lang/ghc-6.10
		${HASKELLDEPS}
		${EXTRALIBS}"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

src_prepare() {
	sed -e 's/parallel/parallel<3/' -i "${S}/${PN}.cabal"
}

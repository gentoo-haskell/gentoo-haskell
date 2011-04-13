# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="XML parser and renderer with HTML 5 quirks mode"
HOMEPAGE="http://hackage.haskell.org/package/xmlhtml"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/blaze-builder-0.4
		>=dev-haskell/blaze-html-0.3.2
		>=dev-haskell/parsec-3.0
		=dev-haskell/text-0.11*
		>=dev-lang/ghc-6.12.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@blaze-builder == 0.2.\*@blaze-builder >= 0.2 \&\& < 0.4@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen blaze-builder dependency in ${S}/${PN}.cabal"
}

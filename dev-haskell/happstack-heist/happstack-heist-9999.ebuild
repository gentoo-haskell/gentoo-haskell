# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit darcs haskell-cabal

DESCRIPTION="Support for using Heist templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="<dev-haskell/blaze-builder-0.4
		=dev-haskell/happstack-server-9999
		=dev-haskell/heist-0.5*
		=dev-haskell/mtl-2*
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@blaze-builder >= 0.2 && <0.3@blaze-builder >= 0.2 \&\& <0.4@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen blaze-builder dependency in ${S}/${PN}.cabal"
}

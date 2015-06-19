# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Support for using Heist templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.2:=[profile?] <dev-haskell/blaze-builder-0.4:=[profile?]
	>=dev-haskell/either-3.4:=[profile?]
	>=dev-haskell/happstack-server-7.0:=[profile?] <dev-haskell/happstack-server-7.4:=[profile?]
	>=dev-haskell/heist-0.13:=[profile?] <dev-haskell/heist-0.14:=[profile?]
	>=dev-haskell/mtl-2:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/text-0.10:=[profile?] <dev-haskell/text-0.12:=[profile?]
	>=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6.0.3
"

src_prepare() {
	cabal_chdeps \
		'either           == 3.4.*' 'either           >= 3.4'
}

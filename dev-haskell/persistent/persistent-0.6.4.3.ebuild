# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit eutils haskell-cabal

DESCRIPTION="Type-safe, non-relational, multi-backend persistence."
HOMEPAGE="http://docs.yesodweb.com/book/persistent"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="postgres sqlite3"

RDEPEND="=dev-haskell/blaze-html-0.4*
		=dev-haskell/data-object-0.3*
		=dev-haskell/enumerator-0.4*
		<dev-haskell/monad-control-0.4
		dev-haskell/mtl
		=dev-haskell/path-pieces-0.0*
		=dev-haskell/pool-0.1*
		<dev-haskell/text-0.12
		>=dev-haskell/time-1.1.4
		=dev-haskell/transformers-0.2*
		dev-haskell/transformers-base
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6.4.3-ghc-7.4-rc1-workaround.patch
	sed -e 's@mtl                      >= 2.0     && < 2.1@mtl                      >= 1.0     \&\& < 2.1@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

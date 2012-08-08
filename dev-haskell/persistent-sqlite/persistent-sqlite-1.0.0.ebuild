# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Backend for the persistent library using sqlite3."
HOMEPAGE="http://www.yesodweb.com/book/persistent"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.5[profile?]
		=dev-haskell/conduit-0.5*[profile?]
		>=dev-haskell/monad-control-0.2[profile?]
		<dev-haskell/monad-control-0.4[profile?]
		=dev-haskell/persistent-1.0*[profile?]
		>=dev-haskell/text-0.7[profile?]
		<dev-haskell/text-1[profile?]
		>=dev-haskell/transformers-0.2.1[profile?]
		<dev-haskell/transformers-0.4[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

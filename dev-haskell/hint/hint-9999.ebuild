# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base darcs haskell-cabal

DESCRIPTION="Runtime Haskell interpreter (GHC API wrapper)"
HOMEPAGE="http://darcsden.com/jcpetruzza/hint"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND="dev-haskell/extensible-exceptions:=[profile?]
		=dev-haskell/ghc-mtl-9999:=[profile?]
		dev-haskell/ghc-paths:=[profile?]
		dev-haskell/haskell-src:=[profile?]
		>=dev-haskell/monadcatchio-mtl-0.3:=[profile?]
		dev-haskell/mtl:=[profile?]
		dev-haskell/random:=[profile?]
		dev-haskell/utf8-string:=[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"

EDARCS_REPOSITORY="http://darcsden.com/jcpetruzza/hint"

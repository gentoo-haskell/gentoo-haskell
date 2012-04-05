# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.17

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Low-level binding to the libyaml C library."
HOMEPAGE="http://github.com/snoyberg/yaml/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-haskell/aeson-0.5[profile?]
		dev-haskell/attoparsec[profile?]
		=dev-haskell/conduit-0.3*[profile?]
		=dev-haskell/resourcet-0.3*[profile?]
		dev-haskell/text[profile?]
		>=dev-haskell/transformers-0.1[profile?]
		<dev-haskell/transformers-0.3[profile?]
		dev-haskell/unordered-containers[profile?]
		dev-haskell/vector[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

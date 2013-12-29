# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Random number generation"
HOMEPAGE="https://github.com/mokus0/random-fu"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/erf:=[profile?]
		dev-haskell/gamma:=[profile?]
		>=dev-haskell/monad-loops-0.3.0.1:=[profile?]
		dev-haskell/random-shuffle:=[profile?]
		=dev-haskell/random-source-0.3*:=[profile?]
		=dev-haskell/rvar-0.2*:=[profile?]
		dev-haskell/syb:=[profile?]
		dev-haskell/transformers:=[profile?]
		>=dev-haskell/vector-0.7:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		=dev-haskell/mtl-2*:=[profile?]
		"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_configure() {
	# workarond bug on ghc-7.6.3, where
	# compilation causes endless loop
	replace-hcflags -O[2-9] -O1

	haskell-cabal_src_configure
}

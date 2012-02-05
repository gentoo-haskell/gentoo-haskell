# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.15

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Convert streams of builders to streams of bytestrings."
HOMEPAGE="http://github.com/snoyberg/conduit"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/blaze-builder-0.2.1.4
		<dev-haskell/blaze-builder-0.4
		>=dev-haskell/conduit-0.2
		>=dev-haskell/text-0.11
		>=dev-haskell/transformers-0.2.2
		<dev-haskell/transformers-0.3
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/hspec-0.9.1
			dev-haskell/hunit
			dev-haskell/quickcheck )"

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

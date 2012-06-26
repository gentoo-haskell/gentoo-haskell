# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# ebuild generated by hackport 0.2.17.9999

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="common functions that show file location information"
HOMEPAGE="https://github.com/gregwebs/FileLocation.hs"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
# tests fail: test: main:Main test/main.hs:30:5 Oh no!
# Test suite test: FAIL
RESTRICT="test"

RDEPEND=">=dev-haskell/transformers-0.2[profile?]
		<dev-haskell/transformers-0.4[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		test? ( dev-haskell/lifted-base[profile?]
		)
		>=dev-haskell/cabal-1.8"

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

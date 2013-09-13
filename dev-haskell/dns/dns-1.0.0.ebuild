# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="DNS library in Haskell"
HOMEPAGE="http://hackage.haskell.org/package/dns"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

# The cabal file has different dependencies for GHC-6.x and 7.x. Rather
# than overcomplicate things, we just require >=dev-lang/ghc-7 and
# manually set the dependencies to those from the GHC-7.x clause.
RDEPEND="dev-haskell/attoparsec:=[profile?]
		dev-haskell/attoparsec-conduit:=[profile?]
		dev-haskell/binary:=[profile?]
		dev-haskell/blaze-builder:=[profile?]
		>=dev-haskell/conduit-0.5:=[profile?]
		>=dev-haskell/iproute-1.2.4:=[profile?]
		dev-haskell/mtl:=[profile?]
		>=dev-haskell/network-2.3:=[profile?]
		dev-haskell/network-conduit:=[profile?]
		dev-haskell/random:=[profile?]
		>=dev-lang/ghc-7:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10
		test? ( dev-haskell/doctest
			dev-haskell/hspec
		)"

# We can't run the "network" or "doctest" testsuites because they
# access the network. But the "spec" testsuite doesn't.
src_test() {
	haskell-cabal_src_test spec
}

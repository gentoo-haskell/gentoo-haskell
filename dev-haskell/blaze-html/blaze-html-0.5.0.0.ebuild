# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A blazingly fast HTML combinator library for Haskell"
HOMEPAGE="http://jaspervdj.be/blaze"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/blaze-builder-0.2[profile?]
		<dev-haskell/blaze-builder-0.4[profile?]
		>=dev-haskell/blaze-markup-0.5.1[profile?]
		<dev-haskell/blaze-markup-0.6[profile?]
		>=dev-haskell/text-0.10[profile?]
		<dev-haskell/text-0.12[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? (
			=dev-haskell/hunit-1.2*
			>=dev-haskell/quickcheck-2.4
			<dev-haskell/quickcheck-2.6
			>=dev-haskell/test-framework-0.4
			<dev-haskell/test-framework-0.7
			=dev-haskell/test-framework-hunit-0.2*
			=dev-haskell/test-framework-quickcheck2-0.2*
		)"

src_prepare() {
	sed -e 's@bytestring    >= 0.9   && < 0.10@bytestring    >= 0.9   \&\& < 0.11@g' \
		-e 's@containers                 >= 0.3 && < 0.5@containers                 >= 0.3 \&\& < 0.6@' \
		-e 's@QuickCheck                 >= 2.4 && < 2.5@QuickCheck                 >= 2.4 \&\& < 2.6@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

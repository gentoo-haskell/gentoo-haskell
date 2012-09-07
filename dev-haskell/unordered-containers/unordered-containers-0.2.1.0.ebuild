# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Efficient hashing-based container types"
HOMEPAGE="http://hackage.haskell.org/package/unordered-containers"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/deepseq-1.1[profile?] <dev-haskell/deepseq-1.4[profile?]
		>=dev-haskell/hashable-1.0.1.1[profile?] <dev-haskell/hashable-1.2[profile?]
		>=dev-lang/ghc-7.4.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? (
			>=dev-haskell/test-framework-0.3.3 <dev-haskell/test-framework-0.7
			dev-haskell/test-framework-hunit
			>=dev-haskell/test-framework-quickcheck2-0.2.9 <dev-haskell/test-framework-quickcheck2-0.3
			>=dev-haskell/quickcheck-2.4.0.1
		)"

src_prepare() {
	sed -e 's@test-framework >= 0.3.3 && < 0.6@test-framework >= 0.3.3 \&\& < 0.7@' \
		-e 's@test-framework >= 0.3.3 && < 0.6@test-framework >= 0.3.3 \&\& < 0.7@' \
		-e 's@containers >= 0.4.1 && < 0.5@containers >= 0.4.1 \&\& < 0.6@g' \
		-e 's@containers >= 0.4.2 && < 0.5@containers >= 0.4.2 \&\& < 0.6@' \
		-e 's@base >= 4 && < 4.6@base >= 4 \&\& < 4.7@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependicies"
}

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

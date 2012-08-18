# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Components of paths."
HOMEPAGE="http://github.com/yesodweb/path-pieces"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="<dev-haskell/text-0.12[profile?]
		dev-haskell/time[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/cabal-1.10
			=dev-haskell/file-location-0.4*[profile?]
			>=dev-haskell/quickcheck-2.4.0.1[profile?]
			>=dev-haskell/hspec-0.9[profile?]
			<dev-haskell/hspec-1.4[profile?]
		)
		"

src_prepare() {
	sed -e 's@hspec >= 0.8 && < 0.9@hspec >= 0.8 \&\& < 1.4@' \
		-e 's@QuickCheck == 2.4.\*@QuickCheck >= 2.4 \&\& < 2.6@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
	# upstream forgot to include the tests
	cp -pR "${FILESDIR}/${PN}-0.1.1/test" "${S}/test" \
		|| die "Could not copy missing tests"
	# upstream forgot to update the tests
	sed -e 's@Route@Path@g' \
		-i "${S}/test/main.hs"
}

src_configure() {
	cabal_src_configure $(use_enable test tests)
}

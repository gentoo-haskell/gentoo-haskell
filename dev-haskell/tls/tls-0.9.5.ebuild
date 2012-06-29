# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="TLS/SSL protocol native implementation (Server and Client)"
HOMEPAGE="http://github.com/vincenthz/hs-tls"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/cereal-0.3[profile?]
		>=dev-haskell/certificate-1.2.0[profile?]
		<dev-haskell/certificate-1.3.0[profile?]
		>=dev-haskell/crypto-api-0.5[profile?]
		>=dev-haskell/cryptocipher-0.3.0[profile?]
		<dev-haskell/cryptocipher-0.4.0[profile?]
		>=dev-haskell/cryptohash-0.6[profile?]
		dev-haskell/mtl[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		test? (
			dev-haskell/quickcheck:2
			dev-haskell/test-framework
			dev-haskell/test-framework-quickcheck2
		)
		"
CABAL_CONFIGURE_FLAGS="$(cabal_flag test)"

PATCHES=("${FILESDIR}/${PN}-0.9.5-ghc-7.5.patch")

src_prepare() {
	base_src_prepare
	cp -r "${FILESDIR}/${P}/Tests/" "${S}/" || die "can't copy test files"
}

#src_configure() {
#	cabal_src_configure $(cabal_flag test)
#}

src_test() {
	"${S}/dist/build/Tests/Tests" || die "tests failed"
}

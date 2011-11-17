# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="Crypto"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collects together existing Haskell cryptographic functions into a package"
HOMEPAGE="http://hackage.haskell.org/package/Crypto"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1
		dev-haskell/hunit
		>=dev-haskell/quickcheck-2.4.0.1"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_test() {
	TESTS="SymmetricTest SHA1Test RSATest QuickTest HMACTest WordListTest"

	for t in $TESTS; do
		einfo "Running test $t..."
		# the quickcheck tests doesn't fail when the test fails...
		"${S}/dist/build/$t/$t" || die "Test $t failed"
	done
}

src_install() {
	cabal_src_install

	rm -rf "${D}/usr/bin" 2>/dev/null
}

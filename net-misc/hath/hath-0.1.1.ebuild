# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin test-suite"
inherit haskell-cabal

DESCRIPTION="Hath manipulates network blocks in CIDR notation."
HOMEPAGE="http://hackage.haskell.org/package/hath"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=dev-haskell/cabal-1.8
		=dev-haskell/cmdargs-0.10*
		=dev-haskell/dns-1*
		=dev-haskell/hunit-1.2*
		=dev-haskell/missingh-1.2*
		=dev-haskell/parallel-io-0.3*
		=dev-haskell/quickcheck-2.6*
		=dev-haskell/split-0.2*
		=dev-haskell/test-framework-0.8*
		=dev-haskell/test-framework-hunit-0.3*
		=dev-haskell/test-framework-quickcheck2-0.3*
		>=dev-lang/ghc-7.6.1
		test? ( =dev-util/shelltestrunner-1.3* )"

# Run only the non-network tests.
src_test() {
	haskell-cabal_src_test testsuite shelltests
}

src_install() {
	cabal_src_install
	doman "${S}/doc/man1/${PN}.1"
}

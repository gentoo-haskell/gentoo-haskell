# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit eutils haskell-cabal

MY_PN="MissingH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Large utility library"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

# testpack dependency is a workaround for cabal-1.8 bug, which pulls
# depends even for 'Buildable: false' target
RDEPEND=">=dev-lang/ghc-6.10
		dev-haskell/hslogger
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/regex-compat"

DEPEND=">=dev-haskell/cabal-1.2.3
		virtual/libiconv
		${RDEPEND}
		test? ( dev-haskell/testpack
			dev-haskell/quickcheck:1
			dev-haskell/hunit )"

# libiconv is needed for the trick below to make it compile with ghc-6.12

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# (non-ASCII non-UTF-8 source breaks hscolour)
	cd src/System/Time
	mv ParseDate.hs ParseDate.hs.ISO-8859-1
	iconv -f ISO-8859-1 -t UTF-8 -c ParseDate.hs.ISO-8859-1 > ParseDate.hs || die "unable to recode ParseDate.hs to UTF-8"
}

src_configure() {
	cabal_src_configure $(cabal_flag test buildtests)
}

src_test() {
	# default tests
	haskell-cabal_src_test || die "cabal test failed"

	# built custom tests
	"${S}/dist/build/runtests/runtests" || die "unit tests failed"
}

src_install() {
	cabal_src_install

	# if tests were enabled, make sure the unit test driver is deleted
	rm -f "${D}/usr/bin/runtests"
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="DPM"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Darcs Patch Manager"
HOMEPAGE="http://hackage.haskell.org/package/DPM"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND=">=dev-lang/ghc-6.8
		>=dev-haskell/cabal-1.6
		dev-haskell/convertible
		>=dev-vcs/darcs-2.4
		>=dev-haskell/hsh-2
		>=dev-haskell/htf-0.3
		dev-haskell/mtl
		dev-haskell/regex-posix
		dev-haskell/split
		dev-haskell/time"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's/ record/ record -A none/' \
	  "${S}/src/DPM/Core/TestDarcs.hs"
}

src_configure() {
	cabal_src_configure \
	  $(cabal_flag test)
}

src_test() {
	"${S}/dist/build/dpm-tests/dpm-tests" || die "dpm-tests failed"
}

src_install() {
	cabal_src_install

	rm "${D}/usr/bin/dpm-tests" 2>/dev/null
}

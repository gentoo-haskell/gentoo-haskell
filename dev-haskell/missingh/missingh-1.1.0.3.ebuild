# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="MissingH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Large utility library"
HOMEPAGE="http://software.complete.org/missingh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

# testpack dependency is a workaround for cabal-1.8 bug, which pulls
# depends even for 'Buildable: false' target
RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/hslogger
		dev-haskell/hunit
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		<dev-haskell/quickcheck-2.0
		dev-haskell/regex-compat
		dev-haskell/testpack"

DEPEND=">=dev-haskell/cabal-1.2.3
		virtual/libiconv
		${RDEPEND}"

# libiconv is needed for the trick below to make it compile with ghc-6.12

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "$A"
	cd "${S}"

	# (non-ASCII non-UTF-8 source breaks hscolour)
	cd src/System/Time
	mv ParseDate.hs ParseDate.hs.ISO-8859-1
	iconv -f ISO-8859-1 -t UTF-8 -c ParseDate.hs.ISO-8859-1 > ParseDate.hs || die "unable to recode ParseDate.hs to UTF-8"
}

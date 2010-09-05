# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="ChasingBottoms"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="For testing partial and infinite values."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/ChasingBottoms"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS="=dev-haskell/mtl-1.1*
		>=dev-haskell/quickcheck-2.1"
RDEPEND=">=dev-lang/ghc-6.10
		${HASKELLDEPS}"
DEPEND="=dev-haskell/cabal-1.8*
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e 's/QuickCheck == 2.1.\*/QuickCheck >= 2.1/' \
		-i "${S}/ChasingBottoms.cabal"
}

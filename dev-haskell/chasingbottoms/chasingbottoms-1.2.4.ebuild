# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="ChasingBottoms"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="For testing partial and infinite values."
HOMEPAGE="http://www.cs.nott.ac.uk/~nad/software/#Chasing Bottoms"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE=""	#Fixme: "OtherLicense", please fill in manually
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/mtl-1.1
		<dev-haskell/quickcheck-2"

S="${WORKDIR}/${MY_P}"

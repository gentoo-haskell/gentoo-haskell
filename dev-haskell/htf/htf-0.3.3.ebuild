# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HTF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Haskell Test Framework"
HOMEPAGE="http://hackage.haskell.org/package/HTF"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/hunit-1.2
		dev-haskell/mtl
		dev-haskell/quickcheck:2"
DEPEND=">=dev-haskell/cabal-1.6
		>=dev-haskell/cpphs-1.11
		>=dev-haskell/haskell-src-exts-1.8.2
	    ${RDEPEND}"

S="${WORKDIR}/${MY_P}"

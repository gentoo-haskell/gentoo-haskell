# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="http://www.cs.chalmers.se/~koen"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.2
		dev-haskell/mtl
		dev-haskell/random"

# would work with ghc 6.8 (6.6 too?) too if we added this dep
# dev-haskell/extensible-exceptions. however, we'd prefer not to add more core
# packages, as we don't want them upgradeable (leads to trouble).
#
# this means that we can only support the architectures which has >=ghc-6.10
# and unfortunately have to drop the other arches until we get proper ghc support :(

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${PN}-2.1.1.1-ghc-7.patch")

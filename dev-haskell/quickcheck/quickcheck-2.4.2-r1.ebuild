# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="http://code.haskell.org/QuickCheck"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="+template_haskell"

RDEPEND=">=dev-lang/ghc-6.10.1
	dev-haskell/random"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

# would work with ghc 6.8 (6.6 too?) too if we added this dep
# dev-haskell/extensible-exceptions. however, we'd prefer not to add more co$
# packages, as we don't want them upgradeable (leads to trouble).
#
# this means that we can only support the architectures which has >=ghc-6.10
# and unfortunately have to drop the other arches until we get proper ghc su$

S="${WORKDIR}/${MY_P}"

src_configure() {
	# GHCi-less platforms do not support Template Haskell
	cabal_src_configure $(cabal_flag template_haskell templateHaskell)
}

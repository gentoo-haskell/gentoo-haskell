# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="Glob"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Globbing library"
HOMEPAGE="http://iki.fi/matti.niemenmaa/glob/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		=dev-haskell/dlist-0*
		=dev-haskell/filepath-1*
		=dev-haskell/mtl-1*"

S="${WORKDIR}/${MY_P}"

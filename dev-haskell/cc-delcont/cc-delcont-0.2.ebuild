# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="CC-delcont"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Delimited continuations and dynamically scoped variables"
HOMEPAGE="http://code.haskell.org/~dolio/CC-delcont"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE=""	#Fixme: "OtherLicense", please fill in manually
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/mtl"

S="${WORKDIR}/${MY_P}"

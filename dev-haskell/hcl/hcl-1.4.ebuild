# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HCL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="High-level library for building command line interfaces."
HOMEPAGE="http://github.com/m4dc4p/hcl/tree/master"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/mtl
		<dev-haskell/quickcheck-2"

S="${WORKDIR}/${MY_P}"

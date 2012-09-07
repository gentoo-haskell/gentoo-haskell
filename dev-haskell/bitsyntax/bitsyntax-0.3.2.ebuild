# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="BitSyntax"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A module to aid in the (de)serialisation of binary data"
HOMEPAGE="http://www.imperialviolet.org/bitsyntax"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/quickcheck"

S="${WORKDIR}/${MY_P}"

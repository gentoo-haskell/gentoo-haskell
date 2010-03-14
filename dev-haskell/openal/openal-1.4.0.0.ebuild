# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="OpenAL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the OpenAL cross-platform 3D audio API"
HOMEPAGE="http://connect.creativelabs.com/openal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/objectname
		dev-haskell/statevar
		dev-haskell/tensor"
DEPEND="dev-haskell/cabal
		${RDEPEND}"

S="${WORKDIR}/${MY_P}"

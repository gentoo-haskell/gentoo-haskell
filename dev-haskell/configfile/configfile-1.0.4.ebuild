# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN=ConfigFile
MY_P=${MY_PN}-${PV}

DESCRIPTION="Parser and writer for handling sectioned config files in Haskell."
HOMEPAGE="http://software.complete.org/configfile"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		dev-haskell/mtl
		dev-haskell/parsec
		>=dev-haskell/missingh-1.0.0"

S="${WORKDIR}/${MY_P}"

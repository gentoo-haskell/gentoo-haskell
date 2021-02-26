# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock"
inherit eutils haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="http://www.math.chalmers.se/~rjmh/QuickCheck/"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"

RDEPEND=">=dev-lang/ghc-6.6.1
	dev-haskell/random:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2
"

PATCHES=( "${FILESDIR}/${P}-ghc-7.10.patch" )

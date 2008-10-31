# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

MY_PN="MonadLab"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Generate layered monads from a simple declaration language"
HOMEPAGE="http://monadgarden.cs.missouri.edu/wiki/index.php/MonadLab"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/parsec
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Analysis and generation of C code"
HOMEPAGE="http://www.sivity.net/projects/language.c/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9.0
		>=dev-haskell/cabal-1.2.3
		dev-haskell/happy
		dev-haskell/alex
		dev-haskell/filepath"

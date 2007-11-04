# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib profile"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

DESCRIPTION="Library for manipulating FilePath's in a cross platform way."
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/projects/libraries.php"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

CABAL_CORE_LIB_GHC_PV="6.8.1"

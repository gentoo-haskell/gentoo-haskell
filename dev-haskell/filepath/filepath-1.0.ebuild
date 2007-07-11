# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="Utilities for filepath handling."
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/projects/libraries.php"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

#if possible try testing with "~ppc"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"

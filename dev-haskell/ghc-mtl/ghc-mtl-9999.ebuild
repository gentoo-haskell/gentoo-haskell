# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit darcs haskell-cabal

DESCRIPTION="Haskell bindings for D-Bus"
HOMEPAGE="http://neugierig.org/software/hdbus/"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
	>=dev-haskell/cabal-1.2
	>=dev-haskell/monadcatchio-mtl-0.2.0.0
	dev-haskell/mtl"

EDARCS_REPOSITORY="http://darcsden.com/jcpetruzza/ghc-mtl"

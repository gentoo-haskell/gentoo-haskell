# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="MonadCatchIO-mtl"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Monad-transformer version of the Control.Exception module"
HOMEPAGE="http://code.haskell.org/~jcpetruzza/MonadCatchIO-mtl"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/extensible-exceptions
		dev-haskell/mtl"

S="${WORKDIR}/${MY_P}"

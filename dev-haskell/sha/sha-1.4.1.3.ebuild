# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="SHA"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations of the SHA suite of message digest functions"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/SHA"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${MY_P}"

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="Binary serialisation library for Haskell"
HOMEPAGE="http://www.n-heptane.com/nhlab/"
SRC_URI="http://www.n-heptane.com/nhlab/repos/NewBinary-${PV}.tgz"

LICENSE="nhc98 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

S="${WORKDIR}/NewBinary"

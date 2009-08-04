# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal versionator

DESCRIPTION="A Haskell Interface to PostgreSQL via the PQ library."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hsql-postgresql"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		>=dev-haskell/hsql-$(get_version_component_range 1-2 ${PV})
		>virtual/postgresql-base-7"

PATCHES=( "${FILESDIR}/${P}-ghc68.patch" )

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal versionator

MY_PV=$(get_version_component_range '1-3')
MY_P="${PN}-${PV}"

DESCRIPTION="Extensible exceptions"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/extensible-exceptions"
# fixme when it'll appear on hackage
#SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

CABAL_CORE_LIB_GHC_PV="7.4.0 7.4.0.20111218"

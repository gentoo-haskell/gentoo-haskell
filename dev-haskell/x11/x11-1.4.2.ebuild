# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.1.6
inherit haskell-cabal

MY_PN="X11"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/X11"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		x11-libs/libX11"

S="${WORKDIR}/${MY_P}"

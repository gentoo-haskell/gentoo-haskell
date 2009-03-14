# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="X11-xft"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Bindings to the Xft, X Free Type interface library, and some Xrender parts"
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		|| ( >=dev-haskell/x11-1.2.1 dev-haskell/x11-darcs )
		>=dev-haskell/utf8-string-0.1
        x11-libs/libXft"

S="${WORKDIR}/${MY_P}"

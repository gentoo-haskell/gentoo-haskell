# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"

inherit base haskell-cabal autotools

MY_PN=X11-extras
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Missing bindings to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/~sjanssen/X11-extras"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.4
	>=dev-haskell/x11-1.2.1
	!dev-haskell/x11-extras-darcs"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	base_src_unpack

	echo '> import Distribution.Simple' > "${S}/Setup.lhs"
	echo '> main = defaultMain' >> "${S}/Setup.lhs"
}

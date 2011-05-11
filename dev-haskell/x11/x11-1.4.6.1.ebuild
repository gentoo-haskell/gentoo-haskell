# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="X11"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/X11"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="xinerama"

RDEPEND=">=dev-lang/ghc-6.8
		x11-libs/libX11
		xinerama? ( x11-libs/libXinerama )"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2
		virtual/libiconv"

# libiconv is needed for the trick below to make it compile with ghc-6.12

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack $A
	cd "${S}"

	# solves http://www.haskell.org/pipermail/glasgow-haskell-users/2009-November/018050.html
	# (non-ASCII non-UTF-8  source breaks hsc2hs)
	# we just mangle evil hyphen
	cd Graphics/X11/Xlib
	mv Extras.hsc Extras.hsc.ISO-8859-1
	iconv -f ISO-8859-1 -t ASCII -c Extras.hsc.ISO-8859-1 > Extras.hsc || die "unable to recode Extras.hsc to UTF-8"
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--configure-option=$(use_with xinerama)"
	cabal_src_compile
}

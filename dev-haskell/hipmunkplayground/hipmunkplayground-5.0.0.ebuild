# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

MY_PN="HipmunkPlayground"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A playground for testing Hipmunk."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/HipmunkPlayground"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="	virtual/opengl"

DEPEND=">=dev-haskell/cabal-1.2
		>=dev-lang/ghc-6.6.1
		>=dev-haskell/glfw-0.3
		>=dev-haskell/hipmunk-5.0
		>=dev-haskell/opengl-2.1
		${RDEPEND}
"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	sed -i 's@containers >= 0.1 \&\& < 0.3@containers >= 0.1 \&\& < 0.4@g' "${S}/${MY_PN}.cabal"
}

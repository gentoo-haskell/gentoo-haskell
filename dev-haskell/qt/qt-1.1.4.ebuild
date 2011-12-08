# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="qtHaskell"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="qtHaskell is a set of Haskell bindings for the Qt Widget Library from Nokia."
HOMEPAGE="http://qthaskell.berlios.de/"
SRC_URI="http://download.berlios.de/qthaskell/${MY_P}.1.tar.bz2"

# The license is uncertain, the web site says its currently GPL, while as the LICENSE file looks like BSD.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/qthaskellc
		dev-haskell/opengl"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

src_install() {
	cabal_src_install
	dodoc INSTALL LICENSE README || die
	dohtml doc/apiGuide/* doc/primer/* doc/userGuide/* || die
}

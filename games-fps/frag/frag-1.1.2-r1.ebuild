# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.5.9999

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="A 3-D First Person Shooter Game"
HOMEPAGE="http://haskell.org/haskellwiki/Frag"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz
	https://dev.gentoo.org/~slyfox/patches/${P}-unrust.patch
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/glut:=
	dev-haskell/hashtables:=
	>=dev-haskell/opengl-2.0:=
	dev-haskell/random:=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2
"

PATCHES=(
	"${DISTDIR}"/${P}-unrust.patch
	"${FILESDIR}"/${P}-ghc-7.8.patch
)

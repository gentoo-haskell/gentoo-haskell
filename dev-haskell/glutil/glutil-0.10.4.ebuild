# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="GLUtil"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Miscellaneous OpenGL utilities"
HOMEPAGE="https://hackage.haskell.org/package/GLUtil"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="demos"

RDEPEND=">=dev-haskell/juicypixels-3:=[profile?]
	>=dev-haskell/linear-1.1.3:=[profile?]
	>=dev-haskell/opengl-3:=[profile?] <dev-haskell/opengl-3.1:=[profile?]
	>=dev-haskell/openglraw-3.0:=[profile?] <dev-haskell/openglraw-3.4:=[profile?]
	>=dev-haskell/vector-0.7:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	demos? ( >=dev-haskell/glfw-b-3.3.0.0:=[profile?] <dev-haskell/glfw-b-3.4:=[profile?] )
"
DEPEND="${RDEPEND}
	dev-haskell/hpp
	>=dev-haskell/cabal-2.0
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag demos demos)
}

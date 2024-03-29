# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999
#hackport: flags: -gl2,gles3:gles,

CABAL_HACKAGE_REVISION=2

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell bindings for nanovg"
HOMEPAGE="https://github.com/cocreature/nanovg-hs"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples gles +truetype"

# Make example executables more resiliant to name collisions
CABAL_CHDEPS=(
	'executable example00' 'executable nanovg-example'
)

RDEPEND="
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	media-libs/glew:0
	virtual/glu
	virtual/libc
	virtual/opengl
	x11-libs/libX11
	examples? (
		dev-haskell/gl:=[profile?]
		dev-haskell/glfw-b:=[profile?]
		dev-haskell/monad-loops:=[profile?]
	)
	truetype? (
		media-libs/freetype:2
	)
"
DEPEND="${RDEPEND}
	dev-haskell/c2hs
	>=dev-haskell/cabal-3.4.1.0
	virtual/pkgconfig
	test? (
		dev-haskell/hspec
		dev-haskell/inline-c
		dev-haskell/quickcheck
	)
"

src_configure() {
	if use truetype; then
		local truetype_flag=-stb_truetype
	else
		local truetype_flag=stb_truetype
	fi

	haskell-cabal_src_configure \
		$(cabal_flag examples examples) \
		--flag=-gl2 \
		$(cabal_flag gles gles3) \
		--flag="${truetype_flag}"
}

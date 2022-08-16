# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.2.2.9999
#hackport: flags: opengl-example:examples:+recent-ish

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Both high- and low-level bindings to the SDL library (version 2.0.6+)"
HOMEPAGE="https://hackage.haskell.org/package/sdl2"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="examples no-linear"

RESTRICT=test #fails if XDG_RUNTIME_DIR and video device cannot be found

RDEPEND=">=dev-haskell/statevar-1.1.0.0:=[profile?] <dev-haskell/statevar-1.3:=[profile?]
	>=dev-haskell/vector-0.10.9.0:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-8.10.1:=
	>=media-libs/libsdl2-2.0.10
	examples? ( dev-haskell/opengl:=[profile?] )
	!no-linear? ( >=dev-haskell/linear-1.10.1.2:=[profile?] <dev-haskell/linear-1.22:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
	virtual/pkgconfig
	test? ( >=dev-haskell/weigh-0.0.8
		no-linear? ( dev-haskell/linear ) )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples) \
		$(cabal_flag no-linear no-linear) \
		$(cabal_flag examples opengl-example) \
		--flag=recent-ish
}

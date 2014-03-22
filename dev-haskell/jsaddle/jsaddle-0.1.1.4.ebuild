# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Edited: 1) ghcjs-base stuff removed as it is not on hackage 2) Rename slotted pkgs

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="High level interface for webkit-javascriptcore"
HOMEPAGE="http://hackage.haskell.org/package/jsaddle"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk3 +jmacro +jsffi webkit"

RDEPEND=">=dev-haskell/lens-3.8.5:=[profile?] <dev-haskell/lens-4.2:=[profile?]
	>=dev-haskell/text-0.11.2.3:=[profile?] <dev-haskell/text-1.2:=[profile?]
	>=dev-haskell/transformers-0.3.0.0:=[profile?] <dev-haskell/transformers-0.4:=[profile?]
	>=dev-lang/ghc-6.10.4:=
	jmacro? ( >=dev-haskell/jmacro-0.6.3:=[profile?] <dev-haskell/jmacro-0.8:=[profile?]
			!webkit? ( gtk3? ( >=dev-haskell/webkit-0.12.5:3=[profile?] <dev-haskell/webkit-0.13:3=[profile?]
						>=dev-haskell/webkitgtk-javascriptcore-0.12.5:3=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:3=[profile?] )
					!gtk3? ( >=dev-haskell/webkit-0.12.5:2=[profile?] <dev-haskell/webkit-0.13:2=[profile?]
						>=dev-haskell/webkitgtk-javascriptcore-0.12.5:2=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:2=[profile?] ) )
			webkit? ( gtk3? ( >=dev-haskell/webkit-0.12.5:3=[profile?] <dev-haskell/webkit-0.13:3=[profile?]
					>=dev-haskell/webkitgtk-javascriptcore-0.12.5:3=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:3=[profile?] )
				!gtk3? ( >=dev-haskell/webkit-0.12.5:2=[profile?] <dev-haskell/webkit-0.13:2=[profile?]
					>=dev-haskell/webkitgtk-javascriptcore-0.12.5:2=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:2=[profile?] ) ) )
	!jmacro? ( !webkit? ( gtk3? ( >=dev-haskell/webkit-0.12.5:3=[profile?] <dev-haskell/webkit-0.13:3=[profile?]
						>=dev-haskell/webkitgtk-javascriptcore-0.12.5:3=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:3=[profile?] )
					!gtk3? ( >=dev-haskell/webkit-0.12.5:2=[profile?] <dev-haskell/webkit-0.13:2=[profile?]
							>=dev-haskell/webkitgtk-javascriptcore-0.12.5:2=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:2=[profile?] ) )
			webkit? ( gtk3? ( >=dev-haskell/webkit-0.12.5:3=[profile?] <dev-haskell/webkit-0.13:3=[profile?]
					>=dev-haskell/webkitgtk-javascriptcore-0.12.5:3=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:3=[profile?] )
				!gtk3? ( >=dev-haskell/webkit-0.12.5:2=[profile?] <dev-haskell/webkit-0.13:2=[profile?]
					>=dev-haskell/webkitgtk-javascriptcore-0.12.5:2=[profile?] <dev-haskell/webkitgtk-javascriptcore-0.13:2=[profile?] ) ) )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/hslogger
		webkit? ( >=dev-haskell/glib-0.12.3.1 <dev-haskell/glib-0.13
				gtk3? ( >=dev-haskell/gtk-0.12.4.1:3 <dev-haskell/gtk-0.13:3 )
				!gtk3? ( >=dev-haskell/gtk-0.12.4.1:2 <dev-haskell/gtk-0.13:2 ) )
		!webkit? ( >=dev-haskell/glib-0.12.3.1 <dev-haskell/glib-0.13
					gtk3? ( >=dev-haskell/gtk-0.12.4.1:3 <dev-haskell/gtk-0.13:3 )
					!gtk3? ( >=dev-haskell/gtk-0.12.4.1:2 <dev-haskell/gtk-0.13:2 ) ) )
"

src_prepare() {
	cabal_chdeps \
		'lens >=3.8.5 && <4.1' 'lens >=3.8.5 && <4.2'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag gtk3 gtk3) \
		$(cabal_flag jmacro jmacro) \
		$(cabal_flag jsffi jsffi) \
		$(cabal_flag webkit webkit)
}

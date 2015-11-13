# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.6.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Examples for the reactive-banana library, using wxHaskell"
HOMEPAGE="http://wiki.haskell.org/Reactive-banana"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="buildexamples"

RDEPEND=">=dev-haskell/cabal-macosx-0.1:=[profile?] <dev-haskell/cabal-macosx-0.3:=[profile?]
	>=dev-haskell/reactive-banana-1.0:=[profile?] <dev-haskell/reactive-banana-1.1:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	|| ( ( >=dev-haskell/wxhaskell-0.13.2.1:2.8=[profile?] <dev-haskell/wxhaskell-0.90:2.8=[profile?] )
		( >=dev-haskell/wxhaskell-0.90.0.1:2.9=[profile?] <dev-haskell/wxhaskell-0.93:2.9=[profile?] ) )
	|| ( ( >=dev-haskell/wxcore-0.13.2.1:2.8=[profile?] <dev-haskell/wxcore-0.90:2.8=[profile?] )
		( >=dev-haskell/wxcore-0.90.0.1:2.9=[profile?] <dev-haskell/wxcore-0.93:2.9=[profile?] ) )
	buildexamples? ( >=dev-haskell/executable-path-0.0:=[profile?] <dev-haskell/executable-path-0.1:=[profile?]
				>=dev-haskell/random-1.0:=[profile?] <=dev-haskell/random-1.1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag buildexamples buildexamples)
}

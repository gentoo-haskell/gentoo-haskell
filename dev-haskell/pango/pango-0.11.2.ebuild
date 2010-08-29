# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Binding to the Pango text rendering engine."
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cairo-0.11.1
		>=dev-haskell/glib-0.11.1
		>=x11-libs/pango-1.0
		>=x11-libs/cairo-1.2.0"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		dev-haskell/gtk2hs-buildtools"

CABAL_CONFIGURE_FLAGS="--flags=new-exception"

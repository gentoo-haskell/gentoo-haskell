# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="GUI functions as used in the book \"The Haskell School of Expression\"."
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/cairo-0.12*
		=dev-haskell/glib-0.12*
		=dev-haskell/gtk-0.12*
		=dev-haskell/stm-2*
		>=dev-lang/ghc-6.10.4
		x11-libs/gtk+"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.13

EAPI=4

#nocabaldep is for the fancy cabal-detection feature at build-time
CABAL_FEATURES="lib profile haddock hscolour hoogle nocabaldep"
inherit base haskell-cabal

DESCRIPTION="Binding to the GLIB library for Gtk2Hs."
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.1
		dev-libs/glib"
DEPEND="${RDEPEND}
		dev-haskell/gtk2hs-buildtools"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Console and GUI interface for Google Translate service"
HOMEPAGE="http://github.com/styx/gtc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
		>=dev-lang/ghc-6.12.1
		>=dev-haskell/cabal-1.8
		dev-haskell/haskeline
		dev-haskell/http
		dev-haskell/json
		dev-haskell/mtl
		dev-haskell/url
		>=dev-haskell/utf8-string-0.3.6
		gtk? ( dev-haskell/glade )"

src_configure() {
	cabal_src_configure $(cabal_flag gtk gui)
}

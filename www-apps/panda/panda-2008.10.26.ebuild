# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A simple static blog engine"
HOMEPAGE="http://www.haskell.org/haskellwiki/Panda"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/cgi
		dev-haskell/filepath
		>=dev-haskell/gravatar-0.3
		>=dev-haskell/kibro-0.4.1
		dev-haskell/missingh
		>=dev-haskell/mps-2008.10.15
		dev-haskell/network
		>=app-text/pandoc-0.46
		>=dev-haskell/parsec-2
		>=dev-haskell/parsedate-3000.0.0
		>=dev-haskell/rss-3000.0.1
		>=dev-haskell/utf8-string-0.3.1
		dev-haskell/xhtml"

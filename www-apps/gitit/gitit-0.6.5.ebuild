# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Wiki using happstack, git or darcs, and pandoc."
HOMEPAGE="http://github.com/jgm/gitit/tree/master"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		>=dev-haskell/cautious-file-0.1.5
		dev-haskell/cgi
		>=dev-haskell/configfile-1
		dev-haskell/datetime
		>=dev-haskell/feed-0.3.6
		dev-haskell/filepath
		>=dev-haskell/filestore-0.3.2
		dev-haskell/ghc-paths
		>=www-servers/happstack-server-0.3.3
		>=www-servers/happstack-util-0.3.2
		dev-haskell/highlighting-kate
		<dev-haskell/hslogger-1.1
		dev-haskell/hstringtemplate
		dev-haskell/http
		dev-haskell/mtl
		>=dev-haskell/network-2.1.0.0
		>=app-text/pandoc-1.2
		<dev-haskell/parsec-3
		>=dev-haskell/recaptcha-0.1
		>dev-haskell/sha-1
		dev-haskell/syb
		dev-haskell/texmath
		dev-haskell/url
		dev-haskell/utf8-string
		dev-haskell/xhtml
		>=dev-haskell/xml-1.3.4
		dev-haskell/zlib"

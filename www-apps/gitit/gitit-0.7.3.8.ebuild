# Copyright 1999-2010 Gentoo Foundation
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

RDEPEND=">=dev-haskell/cautious-file-0.1.5
		dev-haskell/cgi
		<dev-haskell/configfile-1.1
		<dev-haskell/datetime-0.3
		<dev-haskell/feed-0.4
		>=dev-haskell/filestore-0.3.4
		=dev-haskell/happstack-server-0.5*
		=dev-haskell/happstack-util-0.5*
		>=dev-haskell/highlighting-kate-0.2.7.1
		<dev-haskell/hslogger-1.1
		=dev-haskell/hstringtemplate-0.6*
		=dev-haskell/http-4000.0*
		dev-haskell/mtl
		>=dev-haskell/network-2.1.0.0
		>=app-text/pandoc-1.6
		dev-haskell/parsec
		>=dev-haskell/recaptcha-0.1
		dev-haskell/safe
		<dev-haskell/sha-1.5
		=dev-haskell/url-2.1*
		=dev-haskell/utf8-string-0.3*
		dev-haskell/xhtml
		>=dev-haskell/xml-1.3.5
		=dev-haskell/zlib-0.5*
		>=dev-lang/ghc-6.10"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

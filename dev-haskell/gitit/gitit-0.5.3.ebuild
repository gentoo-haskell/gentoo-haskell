# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="Wiki using HAppS, git or darcs, and pandoc."
HOMEPAGE="http://github.com/jgm/gitit/tree/master"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/cgi
		dev-haskell/datetime
		dev-haskell/filepath
		dev-haskell/filestore
		=dev-haskell/happs-server-0.9.3*
		dev-haskell/highlighting-kate
		dev-haskell/hstringtemplate
		dev-haskell/http
		dev-haskell/mtl
		>=dev-haskell/network-2.1.0.0
		>=app-text/pandoc-1.1
		<dev-haskell/parsec-3
		>=dev-haskell/recaptcha-0.1
		>dev-haskell/sha-1
		dev-haskell/utf8-string
		dev-haskell/xhtml
		dev-haskell/zlib"

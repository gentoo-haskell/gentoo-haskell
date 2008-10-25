# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Web development framework."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		dev-haskell/cgi
		dev-haskell/configfile
		dev-haskell/data-default
		dev-haskell/fastcgi
		dev-haskell/filepath
		dev-haskell/mtl
		dev-haskell/regex-compat
		dev-haskell/regexpr
		dev-haskell/safe
		dev-haskell/strict
		dev-haskell/xhtml"

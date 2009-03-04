# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A Haskell library for writing FastCGI programs"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/fastcgi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9.0.1
		>=dev-haskell/cabal-1.2.0
		>=dev-haskell/cgi-3000.0.0
		dev-libs/fcgi"

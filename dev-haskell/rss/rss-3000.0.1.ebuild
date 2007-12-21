# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="A library for generating RSS 2.0 feeds."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/rss"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/network
		=dev-haskell/haxml-1.13*"

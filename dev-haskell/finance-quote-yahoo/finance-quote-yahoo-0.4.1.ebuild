# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

MY_PN="Finance-Quote-Yahoo"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Obtain quote data from finance.yahoo.com"
HOMEPAGE="http://www.b7j0c.org/content/haskell-yquote.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/network
		dev-haskell/http
		dev-haskell/http-simple
		>=dev-haskell/time-1.1.1"

S="${WORKDIR}/${MY_P}"

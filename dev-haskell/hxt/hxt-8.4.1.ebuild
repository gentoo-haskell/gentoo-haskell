# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A collection of tools for processing XML with Haskell."
HOMEPAGE="http://www.fh-wedel.de/~si/HXmlToolbox/index.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.12
		>=dev-haskell/curl-1.3
		>=dev-haskell/deepseq-1.1
		>=dev-haskell/hunit-1.2
		>=dev-haskell/network-2.1
		>=dev-haskell/parsec-2.1
		=dev-haskell/tagsoup-0.8*"

DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

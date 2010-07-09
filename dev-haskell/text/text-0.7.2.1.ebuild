# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="An efficient packed Unicode text type"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/text"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( ( >=dev-lang/ghc-6.10.1
				dev-haskell/deepseq
			  )
			  ( <dev-lang/ghc-6.10.1
				dev-haskell/extensible-exceptions
			  )
			)"
DEPEND=">=dev-haskell/cabal-1.2
        ${RDEPEND}"

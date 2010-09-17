# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell."
HOMEPAGE="http://trac.haskell.org/haskeline"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		<dev-haskell/extensible-exceptions-0.2
		=dev-haskell/mtl-1.1*
		>=dev-haskell/terminfo-0.3.1.3
		<dev-haskell/utf8-string-0.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

CABAL_CONFIGURE_FLAGS="--flags=terminfo"

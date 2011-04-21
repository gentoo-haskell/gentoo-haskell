# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Simple ANSI terminal support, with Windows compatibility"
HOMEPAGE="http://batterseapower.github.com/ansi-terminal"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

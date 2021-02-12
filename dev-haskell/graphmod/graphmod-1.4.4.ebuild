# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="Present the module dependencies of a program as a \"dot\" graph"
HOMEPAGE="https://github.com/yav/graphmod/wiki"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/cabal:=
	>=dev-haskell/dotgen-0.2:= <dev-haskell/dotgen-0.5:=
	>=dev-haskell/haskell-lexer-1.0.2:=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

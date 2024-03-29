# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A simplified view on the haskell-src-exts AST"
HOMEPAGE="https://github.com/int-e/haskell-src-exts-simple"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="1.23/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/haskell-src-exts-1.23:=[profile?] <dev-haskell/haskell-src-exts-1.24:=[profile?]
	>=dev-lang/ghc-8.0.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"

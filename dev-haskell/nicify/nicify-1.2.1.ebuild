# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.5.6

CABAL_FEATURES=""
inherit haskell-cabal

DESCRIPTION="Pretty print the standard output of default 'Show' instances"
HOMEPAGE="https://hackage.haskell.org/package/nicify"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-haskell/nicify-lib-1.0.1:=
	>=dev-lang/ghc-7.4.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A liberalised re-implementation of cpp, the C pre-processor"
HOMEPAGE="http://projects.haskell.org/cpphs/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/old-locale-1.0.0.2:=[profile?] <dev-haskell/old-locale-1.1:=[profile?]
	>=dev-haskell/polyparse-1.13:=[profile?] <dev-haskell/polyparse-1.14:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

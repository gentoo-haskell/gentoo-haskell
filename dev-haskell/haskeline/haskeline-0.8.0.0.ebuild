# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell"
HOMEPAGE="https://github.com/judah/haskeline"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
# keep in sync with ghc-8.10
# KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+terminfo"

RDEPEND=">=dev-haskell/exceptions-0.10:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	>=dev-haskell/stm-2.4:=[profile?] <dev-haskell/stm-2.6:=[profile?]
	>=dev-lang/ghc-8.0.1:=
	terminfo? ( >=dev-haskell/terminfo-0.3.1.3:=[profile?] <dev-haskell/terminfo-0.5:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.24.0.0
"

src_prepare() {
	default

	cabal_chdeps \
		'base >=4.9 && < 4.15' 'base >=4.9'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag terminfo terminfo)
}

CABAL_CORE_LIB_GHC_PV="PM:8.10.1 PM:9999"

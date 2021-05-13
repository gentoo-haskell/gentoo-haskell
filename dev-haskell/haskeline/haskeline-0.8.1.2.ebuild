# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: -examples

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal
RESTRICT="test" # tests require example executable and don't work correctly

DESCRIPTION="A command-line interface for user input, written in Haskell"
HOMEPAGE="https://github.com/judah/haskeline"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+terminfo"

RDEPEND=">=dev-haskell/exceptions-0.10:=[profile?] <dev-haskell/exceptions-0.11:=[profile?]
	>=dev-haskell/stm-2.4:=[profile?] <dev-haskell/stm-2.6:=[profile?]
	>=dev-lang/ghc-8.4.3:=
	terminfo? ( >=dev-haskell/terminfo-0.3.1.3:=[profile?] <dev-haskell/terminfo-0.5:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

src_configure() {
	# The 'examples' cabal flag only enables a single executable, which
	# happens to be only useful for the test
	haskell-cabal_src_configure \
		--flag=-examples \
		$(cabal_flag terminfo terminfo)
}

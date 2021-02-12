# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Abstract data type for canonical file paths"
HOMEPAGE="https://github.com/nominolo/canonical-filepath"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_prepare() {
	cabal_chdeps \
		'deepseq             >= 1.1   && < 1.4' 'deepseq             >= 1.1' \
		'filepath            >= 1.2   && < 1.4' 'filepath            >= 1.2' \
		'directory           >= 1.1   && < 1.3' 'directory           >= 1.1'
}

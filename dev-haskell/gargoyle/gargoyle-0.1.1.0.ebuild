# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Automatically spin up and spin down local daemons"
HOMEPAGE="https://hackage.haskell.org/package/gargoyle"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/filelock-0.1.1:=[profile?] <dev-haskell/filelock-0.2:=[profile?]
	>=dev-haskell/network-2.6.0:=[profile?] <dev-haskell/network-3.2:=[profile?]
	>=dev-lang/ghc-8.6.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
"

src_prepare() {
	default

	cabal_chdeps \
		'base       >=4.12.0 && <4.15' 'base >=4.12.0'
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999
#hackport: flags: -http,+splitbase

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Library and tools to manipulate the Ogg container format"
HOMEPAGE="http://www.kfish.org/software/hogg/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/hunit:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/old-locale:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/time-locale-compat:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

PATCHES=("${FILESDIR}"/${P}-time-1.6.patch)

src_configure() {
	haskell-cabal_src_configure \
		--flag=-http \
		--flag=splitbase
}

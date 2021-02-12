# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Abstraction for things that work like IORef"
HOMEPAGE="https://hackage.haskell.org/package/stateref"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+usestm +usetmvar"

RDEPEND="dev-haskell/mtl:=[profile?]
		>=dev-lang/ghc-6.10.4:=
		usestm? ( dev-haskell/stm:=[profile?]
		)"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag usestm usestm) \
		$(cabal_flag usetmvar usetmvar)
}

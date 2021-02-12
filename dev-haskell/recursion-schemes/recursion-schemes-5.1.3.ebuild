# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1.9999
#hackport: flags: +template-haskell

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Generalized bananas, lenses and barbed wire"
HOMEPAGE="https://github.com/ekmett/recursion-schemes/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base-orphans-0.5.4:=[profile?] <dev-haskell/base-orphans-0.9:=[profile?]
	>=dev-haskell/bifunctors-4:=[profile?] <dev-haskell/bifunctors-6:=[profile?]
	>=dev-haskell/comonad-4:=[profile?] <dev-haskell/comonad-6:=[profile?]
	>=dev-haskell/free-4:=[profile?] <dev-haskell/free-6:=[profile?]
	dev-haskell/nats:=[profile?]
	>=dev-haskell/semigroups-0.10:=[profile?] <dev-haskell/semigroups-1:=[profile?]
	>=dev-haskell/th-abstraction-0.2.4:=[profile?] <dev-haskell/th-abstraction-0.4:=[profile?]
	>=dev-haskell/transformers-compat-0.3:=[profile?] <dev-haskell/transformers-compat-1:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( <dev-haskell/hunit-1.7 )
"

src_prepare() {
	default

	cabal_chdeps \
		'template-haskell >= 2.5.0.0 && < 2.15' 'template-haskell >= 2.5.0.0'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=template-haskell
}

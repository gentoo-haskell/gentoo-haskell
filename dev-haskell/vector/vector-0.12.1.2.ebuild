# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.4.9999
#hackport: flags: -wall

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Efficient Arrays"
HOMEPAGE="https://github.com/haskell/vector"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+boundschecks internalchecks unsafechecks"

RDEPEND=">=dev-haskell/fail-4.9:=[profile?] <dev-haskell/fail-4.10:=[profile?]
	>=dev-haskell/primitive-0.5.0.1:=[profile?] <dev-haskell/primitive-0.8:=[profile?]
	>=dev-haskell/semigroups-0.18:=[profile?] <dev-haskell/semigroups-0.20:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/base-orphans-0.6
		dev-haskell/hunit
		>=dev-haskell/quickcheck-2.9
		dev-haskell/random
		dev-haskell/tasty
		dev-haskell/tasty-hunit
		dev-haskell/tasty-quickcheck
		>=dev-haskell/transformers-0.2.0.0 )
"

src_prepare() {
	default

	cabal_chdeps \
		'QuickCheck >= 2.9 && < 2.14 ' 'QuickCheck >= 2.9'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag boundschecks boundschecks) \
		$(cabal_flag internalchecks internalchecks) \
		$(cabal_flag unsafechecks unsafechecks) \
		--flag=-wall
}

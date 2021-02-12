# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Cron datatypes and Attoparsec parser"
HOMEPAGE="https://github.com/michaelxavier/cron"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="lib-werror"

RDEPEND=">=dev-haskell/attoparsec-0.10:=[profile?]
	>=dev-haskell/data-default-class-0.0.1:=[profile?]
	>=dev-haskell/mtl-2.0.1:=[profile?]
	>=dev-haskell/mtl-compat-0.2.1:=[profile?]
	>=dev-haskell/old-locale-1.0:=[profile?]
	dev-haskell/semigroups:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-2:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/hedgehog
		dev-haskell/tasty
		dev-haskell/tasty-hedgehog
		dev-haskell/tasty-hunit
		dev-haskell/transformers-compat )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag lib-werror lib-werror)
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A high level web scraping library for Haskell"
HOMEPAGE="https://github.com/fimad/scalpel"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/data-default:=[profile?]
	dev-haskell/fail:=[profile?]
	dev-haskell/pointedlist:=[profile?]
	dev-haskell/regex-base:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	>=dev-haskell/tagsoup-0.12.2:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-7.6.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
	test? ( dev-haskell/hunit )
"

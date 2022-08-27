# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.2.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Composable Contravariant Comonadic Logging Library"
HOMEPAGE="https://github.com/co-log/co-log-core"

LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-0.3.1.0-cabal-doctest.patch"
)

RDEPEND=">=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4
	test? ( >=dev-haskell/doctest-0.16
		dev-haskell/cabal-doctest
		>=dev-haskell/glob-0.10.0 <dev-haskell/glob-0.11 )
"

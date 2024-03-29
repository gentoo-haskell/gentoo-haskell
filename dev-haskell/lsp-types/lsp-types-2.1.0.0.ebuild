# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell library for the Microsoft Language Server Protocol, data types"
HOMEPAGE="https://github.com/haskell/lsp"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/aeson-1.2.2.0:=[profile?] <dev-haskell/aeson-2.3:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/diff-0.2:=[profile?]
	dev-haskell/dlist:=[profile?]
	dev-haskell/file-embed:=[profile?]
	>=dev-haskell/hashable-1.3.4.0:=[profile?]
	dev-haskell/indexed-traversable:=[profile?]
	dev-haskell/indexed-traversable-instances:=[profile?]
	>=dev-haskell/lens-4.15.2:=[profile?]
	dev-haskell/lens-aeson:=[profile?]
	dev-haskell/mod:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	dev-haskell/regex:=[profile?]
	>=dev-haskell/row-types-1.0:=[profile?]
	dev-haskell/safe:=[profile?]
	dev-haskell/some:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/aeson-2.0.3.0
		dev-haskell/hspec
		dev-haskell/quickcheck
		dev-haskell/quickcheck-instances )
"

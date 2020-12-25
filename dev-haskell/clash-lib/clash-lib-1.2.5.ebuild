# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="CAES Language for Synchronous Hardware - As a Library"
HOMEPAGE="https://clash-lang.org/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="debug history"

RDEPEND=">=dev-haskell/aeson-0.6.2.0:=[profile?] <dev-haskell/aeson-1.6:=[profile?]
	>=dev-haskell/ansi-terminal-0.8.0.0:=[profile?] <dev-haskell/ansi-terminal-0.12:=[profile?]
	>=dev-haskell/attoparsec-0.10.4.0:=[profile?] <dev-haskell/attoparsec-0.14:=[profile?]
	~dev-haskell/clash-prelude-1.2.5:=[profile?]
	>=dev-haskell/concurrent-supply-0.1.7:=[profile?] <dev-haskell/concurrent-supply-0.2:=[profile?]
	>=dev-haskell/data-binary-ieee754-0.4.4:=[profile?] <dev-haskell/data-binary-ieee754-0.6:=[profile?]
	>=dev-haskell/data-default-0.7:=[profile?] <dev-haskell/data-default-0.8:=[profile?]
	>=dev-haskell/dlist-0.8:=[profile?] <dev-haskell/dlist-1.1:=[profile?]
	>=dev-haskell/errors-1.4.2:=[profile?] <dev-haskell/errors-2.4:=[profile?]
	>=dev-haskell/exceptions-0.8.3:=[profile?] <dev-haskell/exceptions-0.11.0:=[profile?]
	>=dev-haskell/extra-1.6.18:=[profile?] <dev-haskell/extra-1.8:=[profile?]
	>=dev-haskell/hashable-1.2.1.0:=[profile?] <dev-haskell/hashable-1.4:=[profile?]
	>=dev-haskell/haskell-src-meta-0.8:=[profile?] <dev-haskell/haskell-src-meta-0.9:=[profile?]
	>=dev-haskell/hint-0.7:=[profile?] <dev-haskell/hint-0.10:=[profile?]
	>=dev-haskell/interpolate-0.2.0:=[profile?] <dev-haskell/interpolate-1.0:=[profile?]
	>=dev-haskell/lens-4.10:=[profile?] <dev-haskell/lens-4.20:=[profile?]
	>=dev-haskell/mtl-2.1.2:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/ordered-containers-0.2:=[profile?] <dev-haskell/ordered-containers-0.3:=[profile?]
	>=dev-haskell/parsers-0.12.8:=[profile?] <dev-haskell/parsers-1.0:=[profile?]
	>=dev-haskell/prettyprinter-1.2.0.1:=[profile?] <dev-haskell/prettyprinter-2.0:=[profile?]
	>=dev-haskell/primitive-0.5.0.1:=[profile?] <dev-haskell/primitive-1.0:=[profile?]
	>=dev-haskell/reducers-3.12.2:=[profile?] <dev-haskell/reducers-4.0:=[profile?]
	>=dev-haskell/temporary-1.2.1:=[profile?] <dev-haskell/temporary-1.4:=[profile?]
	>=dev-haskell/terminal-size-0.3:=[profile?] <dev-haskell/terminal-size-0.4:=[profile?]
	>=dev-haskell/text-1.2.2:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-haskell/text-show-3.7:=[profile?] <dev-haskell/text-show-3.10:=[profile?]
	>=dev-haskell/trifecta-1.7.1.1:=[profile?] <dev-haskell/trifecta-2.2:=[profile?]
	>=dev-haskell/unordered-containers-0.2.3.3:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/utf8-string-1.0.1:=[profile?] <dev-haskell/utf8-string-1.1:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-1.0:=[profile?]
	>=dev-haskell/vector-binary-instances-0.2.3.5:=[profile?] <dev-haskell/vector-binary-instances-0.3:=[profile?]
	>=dev-lang/ghc-8.4.0:=[profile?] <dev-lang/ghc-8.11:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( dev-haskell/clash-prelude
			dev-haskell/ghc-typelits-knownnat
			dev-haskell/haskell-src-exts
			>=dev-haskell/tasty-1.2 <dev-haskell/tasty-1.5
			dev-haskell/tasty-hunit
		)
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag debug debug) \
		$(cabal_flag history history) \
		$(cabal_flag test unittests)
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Parsing of ISO 8601 dates, originally from aeson"
HOMEPAGE="https://github.com/haskell/aeson"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/attoparsec-0.14.2:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-haskell/integer-conversion-0.1:=[profile?] <dev-haskell/integer-conversion-0.2:=[profile?]
	>=dev-haskell/time-compat-1.9.4:=[profile?] <dev-haskell/time-compat-1.10:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	|| (
		( >=dev-haskell/text-1.2.3.0 <dev-haskell/text-1.3.0.0 )
		( >=dev-haskell/text-2.0 <dev-haskell/text-2.2 )
	)
	dev-haskell/text:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

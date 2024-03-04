# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="POSIX network database (<netdb.h>) API"
HOMEPAGE="https://github.com/haskell/network-bsd"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"

RDEPEND=">=dev-lang/ghc-9.0.2:=
	|| ( ( >=dev-haskell/network-3.0.0.0:=[profile?] <dev-haskell/network-3.0.2:=[profile?] )
		( >=dev-haskell/network-3.1.0.0:=[profile?] <dev-haskell/network-3.2:=[profile?] ) )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

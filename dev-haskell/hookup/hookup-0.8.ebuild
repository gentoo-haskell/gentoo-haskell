# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Abstraction over creating network connections with SOCKS5 and TLS"
HOMEPAGE="https://github.com/glguy/irc-core"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CABAL_CHDEPS=('base                  >=4.11 && <4.20' 'base >=4.11 && <4.22')

RDEPEND=">=dev-haskell/async-2.2:=[profile?] <dev-haskell/async-2.3:=[profile?]
	>=dev-haskell/attoparsec-0.14:=[profile?] <dev-haskell/attoparsec-0.15:=[profile?]
	>=dev-haskell/hsopenssl-0.11.2.3:=[profile?] <dev-haskell/hsopenssl-0.12:=[profile?]
	>=dev-haskell/hsopenssl-x509-system-0.1:=[profile?] <dev-haskell/hsopenssl-x509-system-0.2:=[profile?]
	>=dev-haskell/network-3.0:=[profile?] <dev-haskell/network-3.2:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

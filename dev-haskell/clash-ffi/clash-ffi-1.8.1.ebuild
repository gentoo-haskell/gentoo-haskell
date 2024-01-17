# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Interact with Simulators from Clash"
HOMEPAGE="https://github.com/clash-lang/clash-compiler"

SRC_URI="https://github.com/clash-lang/clash-compiler/archive/refs/tags/v${PV}.tar.gz"
S="${WORKDIR}/clash-compiler-${PV}/${PN}"
CABAL_FILE="${S}/${CABAL_PN}.cabal"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/clash-prelude-1.2:=[profile?] <dev-haskell/clash-prelude-1.10:=[profile?]
	>=dev-haskell/derive-storable-0.3:=[profile?] <dev-haskell/derive-storable-0.4:=[profile?]
	>=dev-haskell/derive-storable-plugin-0.2:=[profile?] <dev-haskell/derive-storable-plugin-0.3:=[profile?]
	dev-haskell/smallcheck:=[profile?]
	dev-haskell/tasty:=[profile?]
	dev-haskell/tasty-hunit:=[profile?]
	dev-haskell/tasty-smallcheck:=[profile?]
	>=dev-lang/ghc-8.8.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
"

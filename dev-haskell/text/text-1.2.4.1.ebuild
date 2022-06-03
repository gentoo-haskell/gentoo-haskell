# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: -bytestring-builder,-developer

CABAL_FEATURES="lib profile haddock hoogle hscolour" # broken test-suite
# break circular dependencies:
# https://github.com/gentoo-haskell/gentoo-haskell/issues/810
CABAL_FEATURES+=" nocabaldep"
inherit haskell-cabal

DESCRIPTION="An efficient packed Unicode text type"
HOMEPAGE="https://github.com/haskell/text"

LICENSE="BSD-2"
SLOT="0/${PV}"
# keep in sync with ghc-8.10.4
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
# break cyclic dependencies, test suite requires porting to >=QC-2.11
RESTRICT=test
RDEPEND=">=dev-lang/ghc-8.8:="

DEPEND="${RDEPEND}
"

CABAL_CORE_LIB_GHC_PV="PM:8.10.5-r1 PM:8.10.6 PM:8.10.7 PM:9.0.1-r1 PM:9999"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-bytestring-builder \
		--flag=-developer
}

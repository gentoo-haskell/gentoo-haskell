# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.2.2.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Common \"Text.Regex.*\" API for Regex matching"
HOMEPAGE="https://wiki.haskell.org/Regular_expressions"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"

RDEPEND=">=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"

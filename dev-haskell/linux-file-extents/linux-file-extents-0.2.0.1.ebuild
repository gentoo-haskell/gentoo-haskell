# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Retrieve file fragmentation information under Linux"
HOMEPAGE="https://github.com/redneb/linux-file-extents"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND=">=dev-lang/ghc-9.6.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.10.1.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples)
}

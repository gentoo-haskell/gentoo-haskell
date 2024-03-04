# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999
#hackport: flags: +newbase,+splitbase,+pkg-config

CABAL_HACKAGE_REVISION=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="PCRE Backend for \"Text.Regex\" (regex-base)"
HOMEPAGE="https://wiki.haskell.org/Regular_expressions"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/regex-base-0.94:=[profile?] <dev-haskell/regex-base-0.95:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	dev-libs/libpcre
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	virtual/pkgconfig
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=newbase \
		--flag=pkg-config \
		--flag=splitbase
}

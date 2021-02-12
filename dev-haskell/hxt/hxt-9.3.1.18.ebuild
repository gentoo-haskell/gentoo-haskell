# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.6.9999
#hackport: flags: +network-uri

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="https://github.com/UweSchmidt/hxt"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

RDEPEND=">=dev-haskell/hxt-charproperties-9.1:=[profile?]
	>=dev-haskell/hxt-regex-xmlschema-9.2:=[profile?]
	>=dev-haskell/hxt-unicode-9.0.1:=[profile?]
	>=dev-haskell/mtl-2.0.1:=[profile?] <dev-haskell/mtl-3:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	>=dev-haskell/parsec-2.1:=[profile?] <dev-haskell/parsec-4:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=network-uri \
		$(cabal_flag profile profile)
}

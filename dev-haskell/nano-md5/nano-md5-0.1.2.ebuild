# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# ebuild generated by hackport 0.2.13

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="Efficient, ByteString bindings to OpenSSL"
HOMEPAGE="http://code.haskell.org/~dons/code/nano-md5"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2:=
	dev-libs/openssl"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2"

PATCHES=("${FILESDIR}"/${PN}-0.1.2-no-fvia-C.patch
	"${FILESDIR}"/${PN}-0.1.2-ghc-7.8.patch)

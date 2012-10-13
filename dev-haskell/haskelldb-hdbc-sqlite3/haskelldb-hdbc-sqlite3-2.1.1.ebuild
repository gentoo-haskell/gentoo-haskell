# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="HaskellDB support for the HDBC SQLite driver."
HOMEPAGE="http://trac.haskell.org/haskelldb"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/haskelldb-2*[profile?]
		=dev-haskell/haskelldb-hdbc-2*[profile?]
		=dev-haskell/hdbc-2*[profile?]
		=dev-haskell/hdbc-sqlite-2*[profile?]
		>=dev-haskell/mtl-1[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@mtl >= 1 && < 2.1@mtl >= 1 \&\& < 2.2@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

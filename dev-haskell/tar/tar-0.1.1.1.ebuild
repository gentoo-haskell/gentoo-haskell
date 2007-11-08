# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="TAR (tape archive format) library."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/tar"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.${PN}.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/binary-0.2
		>=dev-haskell/unix-compat-0.1"

src_unpack() {
	unpack "${A}"

	# fix haddock markup
	sed -i -e 's|@/@|@\\/@|' "${S}/Codec/Archive/Tar/Types.hs"

	cabal-mksetup
}

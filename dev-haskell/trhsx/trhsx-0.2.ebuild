# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="The trhsx translator for haskell-src-exts"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/ghc \
	dev-haskell/haskell-src-exts"

S=${WORKDIR}/haskell-src-exts/src/trhsx

src_unpack() {
	base_src_unpack
	# fix cabal file
	sed -i 's/haskell-src-exts/haskell98,base,haskell-src-exts/' ${S}/trhsx.cabal
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib haddock"
inherit base eutils haskell-cabal

DESCRIPTION="Minimal interface to communicate with a Hackage server."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/${P}.tgz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		dev-haskell/haxr
		dev-haskell/cabal"

S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack
	sed -i -e "s/Build-depends: /Build-depends: mtl, /" "${S}/HackageClient.cabal"
}

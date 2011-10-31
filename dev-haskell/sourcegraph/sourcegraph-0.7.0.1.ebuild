# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal

MY_PN="SourceGraph"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Static code analysis using graph-theoretic techniques."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/SourceGraph"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/cabal-1.8
		dev-haskell/extensible-exceptions
		=dev-haskell/fgl-5.4*
		=dev-haskell/graphalyze-0.12*
		=dev-haskell/graphviz-2999.12*
		<dev-haskell/haskell-src-exts-1.12.0
		dev-haskell/mtl
		dev-haskell/multiset"

# Specify >= 2.24 to get png support
RDEPEND=">=media-gfx/graphviz-2.24.0"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e 's@Cabal >= 1.8 && < 1.11@Cabal >= 1.8 \&\& < 1.13@' \
		-i "${S}/SourceGraph.cabal" || die "Could not loosen dependencies"
}

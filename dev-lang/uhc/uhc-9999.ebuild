# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 autotools

DESCRIPTION="an Utrecht University haskell compiler"
HOMEPAGE="http://www.cs.uu.nl/wiki/UHC/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

EGIT_REPO_URI="git://github.com/UU-ComputerScience/uhc.git"

DEPEND=">=dev-lang/ghc-6.10
	dev-haskell/binary
	dev-haskell/fgl
	dev-haskell/hashable
	dev-haskell/network
	dev-haskell/shuffle
	dev-haskell/syb
	dev-haskell/uuagc
	>=dev-haskell/uhc-util-0.1.5.0
	dev-haskell/uulib"
RDEPEND=""

RESTRICT=test # needs /usr/bin/uhc
MAKEOPTS+=" -j1" # uhc itself fails to build base in parallel

EGIT_SOURCEDIR=${S}
S=${S}/EHC

src_prepare() {
	export HOME=${T} # needs for inplace install
}

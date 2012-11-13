# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="an Utrecht University haskell compiler"
HOMEPAGE="http://www.cs.uu.nl/wiki/UHC/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

EGIT_REPO_URI="git://github.com/UU-ComputerScience/uhc.git"

DEPEND=">=dev-lang/ghc-6.10
	dev-haskell/uulib"
RDEPEND=""

src_prepare() {
	mv EHC/* ./ || die
	export HOME=${T} # needs for inplace install
}

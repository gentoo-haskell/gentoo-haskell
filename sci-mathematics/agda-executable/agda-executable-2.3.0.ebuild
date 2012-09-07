# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal eutils

MY_PN="Agda-executable"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Command-line program for type-checking and compiling Agda programs"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		~sci-mathematics/agda-2.3.0
		>=dev-haskell/cabal-1.8
		>=dev-lang/ghc-6.8.2"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	cabal-mksetup
}

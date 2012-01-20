# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal eutils darcs

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Command-line program for type-checking and compiling Agda programs"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
EDARCS_REPOSITORY="http://code.haskell.org/Agda"
EDARCS_GET_CMD="get --verbose"
EDARCS_LOCALREPO="Agda2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		~sci-mathematics/agda-9999
		>=dev-haskell/cabal-1.8
		>=dev-lang/ghc-6.8.2"

S="${WORKDIR}/${P}/src/main"

src_prepare() {
	cabal-mksetup
}

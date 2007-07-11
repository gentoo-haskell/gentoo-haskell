# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit base darcs haskell-cabal

DESCRIPTION="Lambdabot is a IRC bot written in Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/lambdabot"
LICENSE="GPL-2"
SLOT="${PV}"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=dev-lang/ghc-6.5_pre0"

EDARCS_REPOSITORY="http://www.cse.unsw.edu.au/~dons/lambdabot"
EDARCS_GET_CMD="get --partial"

src_unpack() {
	darcs_src_unpack
	mv "${S}/lambdabot.cabal.ghc-6.6" "${S}/lambdabot.cabal"
}

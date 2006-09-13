# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

MY_PN="HUnit"
GHC_PV=6.5.20060912

DESCRIPTION="A unit testing framework for Haskell."
HOMEPAGE=""
SRC_URI="http://www.haskell.org/ghc/dist/current/dist/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=virtual/ghc-6.5*"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${MY_PN}"

src_unpack() {
	base_src_unpack
	echo "import Distribution.Simple" >> ${S}/Setup.hs
	echo "main = defaultMain" >> ${S}/Setup.hs
}

src_install () {
	cabal_src_install
	if use doc; then
		dohtml -r ${S}/doc/*
	fi
}

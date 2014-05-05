# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin"
inherit haskell-cabal eutils darcs

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Command-line program for type-checking and compiling Agda programs"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
EDARCS_REPOSITORY="http://code.haskell.org/Agda"
EDARCS_LOCALREPO="Agda2"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}
		~sci-mathematics/agda-9999:=
		>=dev-haskell/cabal-1.8
		>=dev-lang/ghc-6.8.2"

# There is a Makefile in this directory, which does not work (or at least
# it does not work without building other stuff), and no .cabal
# file in this directory.
# S="${WORKDIR}/${P}/src/main"

src_prepare() {
	cabal-mksetup
	sed -e '/^library/,/ghc-prof-options: -auto-all/d' \
		-e '/^executable agda-mode/,$d' \
		-i "${S}/${MY_PN}.cabal" \
		|| die "Could not remove library and agda-mode from ${MY_PN}.cabal"
}

src_compile() {
	# The modified Agda.cabal file fails, compile it manually:
	pushd src/main || die "Could not cd to src/main"
	ghc -rtsopts --make Main.hs -O -auto-all -o agda
	popd
}

src_install() {
	dobin "${WORKDIR}/${P}/src/main/agda"
}

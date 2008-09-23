# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="http://www.fh-wedel.de/~si/HXmlToolbox/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		>=dev-haskell/parsec-2.1
		>=dev-haskell/http-3001.0.4
		>=dev-haskell/hunit-1.2
		>=dev-haskell/network-2.1
		>=dev-haskell/tagsoup-0.6
        >=dev-haskell/curl-1.3"

src_install() {
	cabal_src_install

	dodoc README
	if use doc; then
		cd "${S}/doc"
		dodoc thesis.pdf
		dodoc cookbook/doc/thesis.pdf
	fi
}

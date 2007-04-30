# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"

inherit base ghc-package haskell-cabal

MY_P="${P/_rc/-rc}"

DESCRIPTION="Dynamically Loaded Haskell Plugins"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/hs-plugins/"
SRC_URI="http://www.cse.unsw.edu.au/~dons/${PN}/${MY_P}.tar.gz
	doc? ( http://www.cse.unsw.edu.au/~dons/${PN}/${PN}.html.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="<virtual/ghc-6.6
	!>=virtual/ghc-6.6
	>=dev-haskell/haskell-src-exts-0.2
	dev-haskell/cabal"

S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack

	# use hsx
	mv "${S}/plugins.cabal.hsx" "${S}/plugins.cabal"

	# remove warning
	sed -i -e "s/hs-source-dir/hs-source-dirs/" "${S}/plugins.cabal"

	chmod +x "${S}/configure"
}

src_compile() {
	# do this manually instead of relying on haskell-cabal_src_compile
	# since we need to pass on --enable-hsx to configure
	cabal-bootstrap
	cabal-configure --enable-hsx
	cabal-build
}

src_install() {
	haskell-cabal_src_install

	dodoc README LICENSE AUTHORS
}

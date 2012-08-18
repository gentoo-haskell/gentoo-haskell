# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin"
inherit eutils haskell-cabal

DESCRIPTION="Manage sandboxed Haskell build environments"
HOMEPAGE="https://github.com/creswick/cabal-dev"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		<dev-haskell/cabal-1.15
		>=dev-haskell/http-4000.0.9 <dev-haskell/http-4000.3
		<dev-haskell/mtl-2.2
		=dev-haskell/network-2.3*
		=dev-haskell/tar-0.4*
		>=dev-haskell/transformers-0.2 <dev-haskell/transformers-0.4
		=dev-haskell/zlib-0.5*
		>=dev-lang/ghc-6.10.1
		dev-haskell/cabal-install"

# currently we don't run the tests. if we want to, enable -fbuild-tests and
# unpack the cabal-install-0.8.2 into the root of the source tree.

src_prepare() {
	cabal-mksetup
	epatch "${FILESDIR}/${PN}-0.8-cabal-file.patch"
	epatch "${FILESDIR}/${PN}-0.9.1-tf-0.3.patch"
	epatch "${FILESDIR}/${PN}-0.9.1-tar-0.4.patch"
	sed -e 's@tar >= 0.3 && < 0.4@tar@' \
		-i "${S}/${PN}.cabal"
}

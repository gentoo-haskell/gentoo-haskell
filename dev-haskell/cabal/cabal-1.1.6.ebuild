# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap profile lib"
inherit haskell-cabal eutils

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/${P}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="doc"

DEPEND=">=dev-lang/ghc-6.2"

src_unpack() {
	unpack "${A}"
	if ! $(ghc-cabal); then
		sed -i 's/Build-Depends: base/Build-Depends: base, unix/' \
			${S}/Cabal.cabal
	fi
	cd "${S}"
	epatch "${FILESDIR}/${P}-unlit.patch"
}

src_compile() {
	if ghc-cabal; then
		make setup HC="$(ghc-getghc) -ignore-package Cabal"
	else
		make setup HC="$(ghc-getghc)"
	fi
	cabal-configure
	cabal-build
}

src_install() {
	cabal_src_install

	# documentation (install directly)
	dohtml -r doc/users-guide
	if use doc; then
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}

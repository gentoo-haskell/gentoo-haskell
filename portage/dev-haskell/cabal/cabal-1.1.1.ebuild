# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap"
inherit haskell-cabal

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/rc/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="doc"

DEPEND=">=virtual/ghc-6.2"

S="${WORKDIR}/${PN}"

src_compile() {
	make setup
	cabal-configure
	cabal-build
}

src_install() {
	cabal_src_install
	
	# documentation (install directly; generation seems broken to me atm)
	dohtml -r doc/users-guide
	if use doc; then
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}

pkg_postinst () {
	ewarn "If you have an older version of Cabal installed, you may have to"
	ewarn "specify which version you want when you run ghc.  For instance:"
	ewarn ""
	ewarn "  $ ghc -package Cabal"
	ewarn "ghc-6.4: Error; multiple packages match Cabal: Cabal-1.0, Cabal-1.0.1"
	ewarn ""
	ewarn "If you want to avoid this situation, you can remove the"
	ewarn "older version with:"
	ewarn ""
	ewarn "  $ ghc-pkg unregister Cabal-1.0"
}


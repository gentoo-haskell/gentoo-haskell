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
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.2"

CABAL_CORE_LIB_GHC_PV="6.8.1"

src_compile() {
	if ! cabal-is-dummy-lib; then
		make setup HC="$(ghc-getghc)"
		cabal-configure
		cabal-build
	fi
}

src_install() {
	cabal_src_install

	# documentation (install directly)
	if use doc; then
		dohtml -r doc/users-guide
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog LICENSE README releaseNotes TODO
}

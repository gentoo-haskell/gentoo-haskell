# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap profile lib"
inherit base haskell-cabal eutils darcs

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
EDARCS_REPOSITORY="http://darcs.haskell.org/cabal"
EDARCS_GET_CMD="get --partial --verbose"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.4
	dev-haskell/filepath"

src_compile() {
	einfo "Bootstrapping Cabal..."
	$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.lhs \
		-o setup || die "compiling Setup.lhs failed"
	cabal-configure
	cabal-build
}

src_install() {
	cabal_src_install

	dodoc changelog README releaseNotes TODO
}

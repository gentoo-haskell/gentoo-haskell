# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs ghc-package

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="fast"

DEPEND=">=dev-lang/ghc-6.6
		dev-haskell/network
		dev-haskell/mtl
		dev-haskell/html
		>=dev-haskell/cabal-1.1.6"

# Sigh, the testsuite needs to be run inside a ghc build tree
# Not necessarily a built tree mind you, it only needs a few .mk files.
GHC_PV="6.6"
SRC_URI="http://www.haskell.org/ghc/dist/ghc-${GHC_PV}-src.tar.bz2"
EDARCS_REPOSITORY="http://darcs.haskell.org/testsuite"

src_unpack() {
	darcs_src_unpack
	cd "${S}"
	mkdir testsuite
	mv * testsuite/
	unpack "${A}"
	mv testsuite ghc-${GHC_PV}/
}

src_compile() {
	cd "${S}/ghc-${GHC_PV}"
	./configure && \
		make -C utils/mkdependC boot && \
		make -C includes boot && \
		make -C testsuite boot \
			HC=$(ghc-getghc) \
			MKDEPENDHS=$(ghc-getghc) \
		|| die "Preparing the testsuite failed"

	local target
	use fast && target="fast"
	make -C testsuite/tests/ghc-regress ${target} \
		TEST_HC="$(ghc-getghc)" \
		GHC_PKG_INPLACE=$(ghc-getghcpkg) \
		EXTRA_RUNTEST_OPTS="--output-summary=${TMP}/testsuite-summary.txt"
}

src_install() {
	dodoc "${TMP}/testsuite-summary.txt"
}

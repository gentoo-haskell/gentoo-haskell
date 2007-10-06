# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base ghc-package

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"
SRC_URI="http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-src.tar.bz2
	http://www.haskell.org/ghc/dist/${PV}/ghc-testsuite-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="fast"

DEPEND="~dev-lang/ghc-${PV}
		dev-haskell/network
		dev-haskell/mtl
		dev-haskell/html
		>=dev-haskell/cabal-1.1.6"

S="${WORKDIR}/ghc-${PV}"

src_unpack() {
	base_src_unpack

	mv "${WORKDIR}/testsuite" "${S}"
}

src_compile() {
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

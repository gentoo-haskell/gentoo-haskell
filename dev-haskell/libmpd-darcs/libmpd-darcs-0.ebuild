# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"

inherit haskell-cabal darcs

DESCRIPTION="An MPD Client Library"
HOMEPAGE="http://turing.une.edu.au/~bsinclai/code/libmpd-haskell.html"
EDARCS_REPOSITORY="http://turing.une.edu.au/~bsinclai/code/libmpd-haskell"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-haskell/mtl-1.0
	dev-haskell/network
	>=dev-haskell/cabal-1.2
	>=dev-lang/ghc-6.6"
# XXX: should have SLOT dep...
DEPEND="${RDEPEND}
	test? ( =dev-haskell/quickcheck-1* )"

src_install() {
	cabal_src_install
	dodoc ChangeLog README TODO
}

src_test() {
	if use test ; then
		"${S}"/tests/run-tests || die "test suite failed"
	fi
}

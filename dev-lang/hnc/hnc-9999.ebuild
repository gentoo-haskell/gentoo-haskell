# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=4

CABAL_FEATURES="bin"
inherit eutils git-2 haskell-cabal

MY_PN="HNC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="source-to-source translator of a variant of ML core into C++"
HOMEPAGE="http://github.com/kayuri/HNC"
EGIT_REPO_URI="git://github.com/kayuri/${MY_PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	=dev-haskell/hunit-1*
	=dev-haskell/mtl-2*
	>=dev-haskell/parsec-3.1
	dev-haskell/quickcheck:2
	dev-haskell/uuagc
	>=dev-lang/ghc-7.2"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	find "${S}" -name '*.ag' | while read bad_file; do
		mv -v "${bad_file}" "${bad_file}.orig" || die
		# uuagc does not handle NON-ASCII encodings
		iconv -c -f UTF-8 -t ASCII < "${bad_file}.orig" >"${bad_file}" || die
	done
}

src_configure() {
	cabal_src_configure $(use_enable test tests)
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal eutils

DESCRIPTION="Parsing and extracting information from (possibly malformed) HTML/XML documents"
HOMEPAGE="http://community.haskell.org/~ndm/tagsoup/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/mtl
		dev-haskell/network"
DEPEND=">=dev-haskell/cabal-1.6
		>=dev-lang/ghc-6.10.1
		${RDEPEND}"

CABAL_CONFIGURE_FLAGS="--flags=-testprog"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Disable bringing in unneeded deps used just for testing purposes.
	epatch "${FILESDIR}/${P}-fix_test_deps.patch"
}

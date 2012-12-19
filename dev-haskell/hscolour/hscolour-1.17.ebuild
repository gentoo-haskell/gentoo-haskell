# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# disabled haddock as there is USE="doc hscolour" case with circular depends
CABAL_FEATURES="bin lib profile"
inherit base haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${PN}-1.17-no-haskell98.patch")

src_install() {
	cabal_src_install
	if use doc; then
		dohtml hscolour.css
	fi
}

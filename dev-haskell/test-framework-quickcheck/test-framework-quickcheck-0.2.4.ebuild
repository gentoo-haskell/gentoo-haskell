# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="QuickCheck support for the test-framework package."
HOMEPAGE="http://batterseapower.github.com/test-framework/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2.3
		>=dev-haskell/extensible-exceptions-0.1.1
		dev-haskell/parallel
		=dev-haskell/quickcheck-1*
		>=dev-haskell/test-framework-0.2.0"

src_unpack() {
	base_src_unpack

	# the .cabal allows that neither the base3 or the base4 branch is taken,
	# when can happen if your environment is broken (parallel is installed
	# according to portage, but not registered with ghc-pkg)
	sed -e 's/if flag(base4)//' -i "${S}/${PN}.cabal"
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit darcs haskell-cabal

DESCRIPTION="Efficient relational queries on Haskell sets."
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/happstack-data-9999
		=dev-haskell/happstack-util-9999
		<dev-haskell/mtl-2.1
		>=dev-haskell/syb-with-class-0.6.1
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

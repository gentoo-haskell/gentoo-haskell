# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile hscolour haddock hoogle"
inherit darcs haskell-cabal

DESCRIPTION="The haskell application server stack + code generation"
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/happstack-server-9999[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

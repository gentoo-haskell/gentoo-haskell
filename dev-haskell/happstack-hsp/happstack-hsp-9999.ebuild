# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit darcs haskell-cabal

DESCRIPTION="Support for using HSP templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/happstack-server-9999
		=dev-haskell/harp-0.4*
		<dev-haskell/hsp-0.7
		<dev-haskell/hsx-0.10
		<dev-haskell/mtl-2.1
		<dev-haskell/text-0.12
		dev-haskell/utf8-string
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

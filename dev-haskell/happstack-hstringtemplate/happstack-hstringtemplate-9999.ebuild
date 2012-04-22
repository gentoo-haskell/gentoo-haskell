# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Support for using HStringTemplate in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/happstack-server-9999[profile?]
		dev-haskell/hslogger[profile?]
		<dev-haskell/hstringtemplate-0.7[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

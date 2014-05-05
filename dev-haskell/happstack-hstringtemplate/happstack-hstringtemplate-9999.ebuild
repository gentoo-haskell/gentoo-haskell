# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Support for using HStringTemplate in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"


S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-haskell/happstack-server-6.0:=[profile?]
		dev-haskell/hslogger:=[profile?]
		>=dev-haskell/hstringtemplate-0.4.3:=[profile?]
		<dev-haskell/hstringtemplate-0.8:=[profile?]
		>=dev-haskell/mtl-1.1:=[profile?]
		<dev-haskell/mtl-2.2:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

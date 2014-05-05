# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Support for Hamlet HTML templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE=""

RDEPEND=">=dev-haskell/hamlet-0.10:=[profile?]
		<dev-haskell/hamlet-1.2:=[profile?]
		=dev-haskell/happstack-server-9999:=[profile?]
		dev-haskell/text:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="The haskell application server stack + reload"
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/happstack-server-9999[profile?]
		>=dev-haskell/mtl-2.0[profile?]
		<dev-haskell/mtl-2.2[profile?]
		=dev-haskell/plugins-auto-0.0*[profile?]
		=dev-haskell/th-lift-0.5*[profile?]
		>=dev-lang/ghc-6.12.3"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

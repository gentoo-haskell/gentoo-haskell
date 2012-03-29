# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.17

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="blaze-html instances for xml-conduit types"
HOMEPAGE="http://github.com/snoyberg/xml"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/blaze-html-0.4*[profile?]
		>=dev-haskell/text-0.5[profile?]
		<dev-haskell/text-1[profile?]
		>=dev-haskell/xml-conduit-0.5[profile?]
		<dev-haskell/xml-conduit-0.7[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

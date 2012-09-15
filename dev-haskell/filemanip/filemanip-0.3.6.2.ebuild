# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Expressive file and directory manipulation for Haskell."
HOMEPAGE="http://bitbucket.org/bos/filemanip"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/mtl[profile?]
		dev-haskell/unix-compat[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

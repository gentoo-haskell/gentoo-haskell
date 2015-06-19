# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit git-2 haskell-cabal

DESCRIPTION="Cloud Haskell. Fault-tolerant distributed computing framework"
HOMEPAGE="http://hackage.haskell.org/package/remote"
EGIT_REPO_URI="git://github.com/jepst/CloudHaskell.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary[profile?]
		dev-haskell/mtl[profile?]
		dev-haskell/network[profile?]
		dev-haskell/puremd5[profile?]
		dev-haskell/stm[profile?]
		dev-haskell/syb[profile?]
		dev-haskell/utf8-string[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

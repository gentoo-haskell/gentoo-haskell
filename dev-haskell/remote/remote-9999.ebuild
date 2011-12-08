# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit git-2 haskell-cabal

DESCRIPTION="Cloud Haskell. Fault-tolerant distributed computing framework"
HOMEPAGE="http://hackage.haskell.org/package/remote"
EGIT_REPO_URI="git://github.com/jepst/CloudHaskell.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/puremd5
		dev-haskell/stm
		dev-haskell/time
		dev-haskell/utf8-string
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

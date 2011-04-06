# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit git haskell-cabal

DESCRIPTION="Fault-tolerant distributed computing framework"
HOMEPAGE="https://github.com/jepst/CloudHaskell"
EGIT_REPO_URI="git://github.com/jepst/CloudHaskell.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/stm
		dev-haskell/time
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

src_prepare() {
	cp "${FILESDIR}/Setup.hs" "${S}"
}

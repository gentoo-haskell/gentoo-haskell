# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal git-2

DESCRIPTION="Webkit Browser"
HOMEPAGE="http://github.com/baldo/lambdacat"
EGIT_REPO_URI="git://github.com/Nensha/lambdacat.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/cmdargs-0.6[profile?]
		>=dev-haskell/dyre-0.8.5[profile?]
		<dev-haskell/dyre-0.9[profile?]
		=dev-haskell/glade-0.12*[profile?]
		=dev-haskell/gtk-0.12*[profile?]
		=dev-haskell/mtl-2*[profile?]
		>=dev-haskell/network-2.2[profile?]
		>=dev-haskell/webkit-0.12.1[profile?]
		<dev-haskell/webkit-0.13[profile?]
		>=dev-lang/ghc-6.12.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

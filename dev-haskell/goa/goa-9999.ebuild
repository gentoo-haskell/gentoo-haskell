# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="3"
CABAL_FEATURES="bin lib profile"
inherit git haskell-cabal

DESCRIPTION="GHCi on Acid is an extension to GHCi (Interactive GHC) for adding useful lambdabot features."
HOMEPAGE="http://haskell.org/haskellwiki/GHC/GHCi#GHCi_on_Acid"
EGIT_REPO_URI="git://github.com/chrisdone/goa.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/lambdabot"
DEPEND="$RDEPEND
		app-portage/gentoolkit
		>=dev-haskell/cabal-1.2"

src_prepare() {
	sed -e 's@setLambdabotHome "/home/dons/lambdabot"@setLambdabotHome "/usr/bin"@' -i "${S}/dot-ghci"
	sed -e 's@import qualified Control.Exception as C@import qualified Control.OldException as C@' -i "${S}/GOA.hs"
}

pkg_postinst() {
	ghc-package_pkg_postinst
	DOT_GHCI=$(equery files dev-haskell/goa | grep dot-ghci)
	elog "To configure a trippin' ghci, add $DOT_GHCI to your ~/.ghci"
}

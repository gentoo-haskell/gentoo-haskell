# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="The command-line interface for Cabal and Hackage."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		=dev-haskell/cabal-1.4*
		dev-haskell/filepath
		dev-haskell/network
		dev-haskell/http
		>=dev-haskell/zlib-0.4"

src_install() {
    haskell-cabal_src_install

    dobashcompletion "${S}/bash-completion/cabal"
}

pkg_postinst() {
    ghc-package_pkg_postinst

    bash-completion_pkg_postinst
}


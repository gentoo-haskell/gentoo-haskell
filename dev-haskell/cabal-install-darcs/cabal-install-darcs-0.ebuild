# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
CABAL_FEATURES="bin"
inherit base bash-completion haskell-cabal eutils darcs

DESCRIPTION="Command line interface to the Cabal/Hackage system"
HOMEPAGE="http://haskell.org/cabal"
EDARCS_REPOSITORY="http://darcs.haskell.org/cabal-install"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6
		=dev-haskell/cabal-darcs-1.4*
		dev-haskell/zlib
		dev-haskell/http"

src_install() {
	haskell-cabal_src_install

	dobashcompletion "${S}/bash-completion/cabal"
}

pkg_postinst() {
	ghc-package_pkg_postinst

	bash-completion_pkg_postinst
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal flag-o-matic

DESCRIPTION="Haskell IDE written in Haskell"
HOMEPAGE="http://www.leksah.org"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/binary-0.4.4
		>=dev-haskell/bytestring-0.9.0.1
		>=dev-haskell/cabal-1.6.0.1
		>=dev-haskell/filepath-1.1.0.1
		>=dev-haskell/gtk2hs-0.10.0_rc
		>=x11-libs/gtksourceview-2.4.0
		>=dev-haskell/mtl-1.1.0.2
		>=dev-haskell/parsec-2.1.0.1
		>=dev-haskell/regex-posix-0.72.0.3
		>=dev-haskell/utf8-string-0.3.1.1"

pkg_setup () {
	ghc-package_pkg_setup
	if ! ( built_with_use dev-haskell/gtk2hs gnome ); then
		eerror "${P} requires dev-haskell/gtk2hs to have been built with USE flag gnome"
		die "Please re-emerge gtk2hs with USE=\"gnome\""
	fi
}

# >=gtksourceview2-2.4.0 is required to get the
# sourceLanguageManagerGuessLanguage function

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit git-2 haskell-cabal

DESCRIPTION="A fast syntax highlighting library built with alex."
HOMEPAGE="http://github.com/jgm/illuminate"
EGIT_REPO_URI="git://github.com/jgm/illuminate"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="executable"

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/html
		dev-haskell/utf8-string
		dev-haskell/xhtml
		dev-haskell/hscolour
		dev-haskell/filemanip"
DEPEND="$RDEPEND
		>=dev-haskell/cabal-1.2
		dev-haskell/alex"

src_prepare() {
	if has_version ">=dev-haskell/filemanip-0.3.5.2"; then
		sed -e 's@FileManip@filemanip@' \
			-i "${S}/${PN}.cabal" || die "Could not change FileManip to filemanip in ${S}/${PN}.cabal"
	fi
}

src_configure() {
	cabal_src_configure $(cabal_flag executable)
}

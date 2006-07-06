# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit haskell-cabal darcs

DESCRIPTION="hImerge is a graphical user interface for emerge (Gentoo's Portage system) written in Haskell using gtk2hs."
HOMEPAGE="http://haskell.org/~luisfaraujo/himerge/"
LICENSE="GPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

EDARCS_REPOSITORY="http://haskell.org/~luisfaraujo/himerge/"
EDARCS_GET_CMD="get --partial --verbose"
EDARCS_LOCALREPO="himerge"

DEPEND=">=dev-lang/ghc-6.4
	dev-haskell/cabal
	dev-haskell/gtk2hs
	(|| ( www-client/mozilla-firefox 
		www-client/mozilla ) )"
RDEPEND=""

src_install() {
	cabal-copy
	cabal-pkg
	dodir /usr/local/share/himerge-icons
	insinto /usr/local/share/himerge-icons
	doins ${S}/himerge-icons/*
}

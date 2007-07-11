# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit base haskell-cabal

DESCRIPTION="Haskell Graphical User Interface for the Gentoo's Portage System."
HOMEPAGE="http://www.haskell.org/himerge/"
SRC_URI="http://www.haskell.org/himerge/release/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/gtk2hs-0.9.11
	>=app-portage/eix-0.9.3"
RDEPEND=""

pkg_setup() {
	if ! built_with_use -o dev-haskell/gtk2hs firefox ; then
	   	echo
		eerror "gtk2hs was not merged with the firefox USE flag."
		eerror "Himerge requires gtk2hs be compiled with any of these flags."
		die "gtk2hs missing web browser support."
	fi
}

src_install() {
	cabal-copy
	cabal-pkg
	einfo "Installing data files."
	mkdir -p ${D}/usr/local/share/himerge/{css,icons}
	cp ${S}/data/himerge/css/himerge.css ${D}/usr/local/share/himerge/css
	cp ${S}/data/himerge/icons/* ${D}/usr/local/share/himerge/icons/
}

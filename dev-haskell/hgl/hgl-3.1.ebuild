# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit ghc-package

DESCRIPTION="A simple graphics library based on X11 or Win32."
HOMEPAGE=""
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="x86 amd64"
IUSE=""

DEPEND="=virtual/ghc-6.4*"

pkg_setup () {
	ghc-package_pkg_setup
	einfo "This library is already provided by ghc. This ebuild does nothing."
}

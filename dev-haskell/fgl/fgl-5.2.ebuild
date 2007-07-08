# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit ghc-package

DESCRIPTION="A functional graph library for Haskell."
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=virtual/ghc-6.4*
		!>=virtual/ghc-6.6"

pkg_setup () {
	ghc-package_pkg_setup
	elog "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}

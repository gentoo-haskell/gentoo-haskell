# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit ghc-package flag-o-matic

DESCRIPTION="A Haskell binding to the OpenAL cross-platform 3D audio API"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/ghc-6.4*"

# GHC 6.4.1 provides openal-1.0
# GHC 6.4.2 provides openal-1.2
# We treat them as the same version, openal-1.2

pkg_setup () {
	ghc-package_pkg_setup
	if ! built_with_use dev-lang/ghc openal; then
		eerror "This library has to be provided by ghc."
		eerror "Please re-emerge ghc with USE=\"openal\""
		die "dev-haskell/openal requires ghc to be built with USE=\"openal\""
	fi
	einfo "This library is already provided by ghc. This ebuild does nothing."
}

src_install () {
	dodir "$(ghc-libdir)"
	touch "${D}/$(ghc-libdir)/.${P}.ghc-updater"
}

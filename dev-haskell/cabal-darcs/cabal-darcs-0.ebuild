# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap profile lib"

inherit haskell-cabal eutils base darcs

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="doc"

DEPEND=">=virtual/ghc-6.4
	doc? (app-text/docbook-sgml-utils)"
# version of docbook-sgml-utils required?

EDARCS_REPOSITORY="http://darcs.haskell.org/packages/Cabal"
EDARCS_GET_CMD="get --partial --verbose"

src_compile() {
	if ghc-cabal; then
		make setup HC="$(ghc-getghc) -ignore-package Cabal"
	else
		make setup HC="$(ghc-getghc)"
	fi
	cabal-configure
	cabal-build

	# compile doc/Cabal.xml
	if use doc; then
		(cd doc; make)
	fi
}

src_install() {
	cabal_src_install

	if use doc; then
		dodoc doc/Cabal.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}

pkg_postinst () {
	# FIXME? still needed?
	if ghc-cabal && ghc-package-exists "Cabal-1.0"; then
	        ebegin "Unregistering ghc's built-in cabal "
	        $(ghc-getghcpkg) unregister "Cabal-1.0" > /dev/null
	        eend $?
	fi
	ghc-package_pkg_postinst
}


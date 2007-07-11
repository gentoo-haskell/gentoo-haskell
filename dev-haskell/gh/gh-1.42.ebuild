# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.15.ebuild,v 1.7 2005/10/04 15:12:34 dcoutts Exp $

inherit ghc-package

DESCRIPTION="A language for Generic Programming"
HOMEPAGE="http://www.generic-haskell.org/"
SRC_URI="http://www.cs.uu.nl/research/projects/generic-haskell/compiler/coral/${P}-source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.2.2
	>=dev-haskell/uuagc-0.9.1
	>=dev-haskell/frown-0.6
	>=dev-haskell/drift-2.1.1"
RDEPEND=">=dev-lang/ghc-6.2.2"

src_unpack() {
	unpack ${A}

	# patch source
	sed -i 's/\(FROWN.*\)-o/\1-O/' ${S}/src/uha/local.mk || die "patch failed"
	sed -i 's/import Set$/import Set hiding (map, filter, toList, fromList, null, (\\\\))/' ${S}/src/main/*.{lag,ag,hs} ${S}/src/types/*.{lag,hs} || die "patch failed"
}

src_compile() {
	cd build
	ECONF_SOURCE=".." econf || die "configure failed"
	emake realclean || die "make realclean failed"
	emake TRADITIONAL=1 || die "make failed"
}

src_install() {
	cd build
	make install DESTDIR="${D}" || die "make install failed"
	if $(ghc-cabal); then
		ghc-setup-pkg generic-haskell.cabal.pkg
	else
		ghc-setup-pkg "${S}/generic-haskell.pkg"
	fi
	ghc-install-pkg
}

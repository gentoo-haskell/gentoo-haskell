# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haxml/haxml-1.12.ebuild,v 1.2 2005/04/05 16:23:19 kosmikus Exp $

inherit ghc-package fixheadtails

MY_PN=HaXml
MY_P=${MY_PN}-${PV}

DESCRIPTION="Haskell utilities for parsing, filtering, transforming and generating XML documents"
HOMEPAGE="http://www.haskell.org/HaXml/"
SRC_URI="http://www.haskell.org/HaXml/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"

IUSE="doc"

# actually, >=ghc-5.02 should be ok
# hugs and nhc98 are ok too, somebody might want to add support for them
DEPEND=">=virtual/ghc-6.0
	doc? ( >=dev-haskell/haddock-0.6-r2 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	ht_fix_file ${S}/configure
}

src_compile() {

	./configure --prefix=${D}/usr/bin \
		|| die "./configure failed"
	# we only support ghc currently; overrides auto-detection
	echo ghc > ${S}/obj/compilers

	emake -j1 || die "make failed"

	# create documentation if requested
	if use doc; then
		emake -j1 haddock || die "make doc failed"
	fi

	# prepare installation of the pkg.conf-file
	if $(ghc-cabal); then
		ghc-setup-pkg ${FILESDIR}/${MY_P}.cabal
	else
		ghc-setup-pkg ${S}/obj/ghc/pkg.conf
	fi
	# make sure the libdir is correct
	sed -i "s:\$libdir:$(ghc-libdir):" $(ghc-localpkgconf)
}

src_install() {
	# fix so it installs into image dir
	echo ${D}/$(ghc-libdir) > ${S}/obj/ghc/ghclibdir
	echo ${D}/$(ghc-libdir)/imports > ${S}/obj/ghc/ghcincdir
	# make sure all installation directories are there
	mkdir -p ${D}/$(ghc-libdir)/imports

	emake -j1 install-filesonly || die "make install failed"

	if use doc; then
		dohtml -r docs/*
		dodoc docs/icfp99.dvi docs/icfp99.ps.gz
	fi

	ghc-install-pkg
}


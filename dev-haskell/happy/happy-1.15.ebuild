# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/happy/happy-1.15.ebuild,v 1.13 2006/08/26 20:41:12 wormo Exp $

inherit base eutils ghc-package

DESCRIPTION="A yacc-like parser generator for Haskell"
HOMEPAGE="http://haskell.org/happy/"
SRC_URI="http://haskell.cs.yale.edu/happy/dist/${PV}/${P}-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc"
#java use flag disabled, bug #107019

DEPEND=">=virtual/ghc-5.04
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets )"
#		java? ( >=dev-java/fop-0.20.5 ) )"
RDEPEND=""

src_unpack() {
	base_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/${P}-ghc66.patch"
}

src_compile() {
	econf || die "configure failed"
	if $(ghc-cabal); then
		echo "SRC_HC_OPTS += -ignore-package util" >> mk/build.mk
	fi
	emake -j1 || die "make failed"
	if use doc; then
		emake -j1 html || die "make html failed"
		#if use java; then
		#	emake -j1 ps || die "make ps failed"
		#fi
	fi
}

src_install() {
	local docways
	if use doc; then
		docways="html"
		#use java && docways="${docways} ps"
	else
		docways=""
	fi
	# the libdir0 setting is needed for amd64, and does not
	# harm for other arches; einstall doesn't seem to work
	make install install-docs XMLDocWays="${docways}" \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/${P}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" \
		libdir0="${D}/usr/$(get_libdir)" \
		|| die "installation failed"
}

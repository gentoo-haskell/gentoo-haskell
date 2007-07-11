# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-util/darcs/darcs-0.9.17.ebuild,v 1.2 2004/03/18 08:27:31 kosmikus Exp $

inherit darcs

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
EDARCS_REPOSITORY="http://www.abridgegame.org/repos/darcs"
EDARCS_GET_CMD="get --verbose"

DEPEND="sys-devel/autoconf
	>=net-misc/curl-7.10.2
	>=dev-lang/ghc-6.2
	doc?  ( virtual/tetex
		dev-tex/latex2html )"

RDEPEND=">=net-misc/curl-7.10.2"

S=${WORKDIR}/${P/_rc/rc}

src_compile() {
	local myconf
	autoconf
	make clean || die "make clean failed"
	if use doc ; then
		sed -i "s:/doc:/doc/${PF}:" GNUmakefile
	else
		sed -i \
			-e 's: installdocs::' \
			-e 's:^.*BUILDDOC.*yes.*$::' \
			-e 's/^.*TARGETS.*\(darcs\.ps\|manual\).*$/:/' \
			configure
	fi
	econf ${myconf} || die "configure failed"
	echo 'INSTALLWHAT=installbin' >> autoconf.mk
	make all || die "make failed"
}

src_test() {
	make test
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
	elog "Renaming the main executable to darcs-darcs."
	mv ${D}/usr/bin/darcs ${D}/usr/bin/${PN}
}

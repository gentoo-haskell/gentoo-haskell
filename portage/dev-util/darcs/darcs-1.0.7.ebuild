# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-1.0.5.ebuild,v 1.3 2006/01/11 05:36:18 halcy0n Exp $

inherit base

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
MY_P0="${P/_rc/rc}"
MY_P="${MY_P0/_pre/pre}"
SRC_URI="http://abridgegame.org/darcs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"
# disabled wxwindows use flag for now, as I got build errors

DEPEND=">=net-misc/curl-7.10.2
	virtual/mta
	>=virtual/ghc-6.2.2
	doc?  ( virtual/tetex
		dev-tex/latex2html )"
#	wxwindows?  ( dev-haskell/wxhaskell )

RDEPEND=">=net-misc/curl-7.10.2
	virtual/mta"
#	wxwindows?  ( dev-haskell/wxhaskell )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack

	# If we're going to use the CFLAGS with GHC's -optc flag then we'd better
	# use it with -opta too or it'll break with some CFLAGS, eg -mcpu on sparc
	sed -i 's:\($(addprefix -optc,$(CFLAGS))\):\1 $(addprefix -opta,$(CFLAGS)):' \
		${S}/autoconf.mk.in
}

src_compile() {
	local myconf
#	myconf="`use_with wxwindows wx`"
	# distribution contains garbage files
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
	emake all || die "make failed"
}

src_test() {
	make test
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
}

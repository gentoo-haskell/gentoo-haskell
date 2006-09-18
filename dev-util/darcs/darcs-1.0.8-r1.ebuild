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
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=net-misc/curl-7.10.2
	virtual/mta
	>=virtual/ghc-6.2.2
	doc?  ( virtual/tetex
			>=dev-tex/latex2html-2002.2.1_pre20041025-r1 )"

RDEPEND=">=net-misc/curl-7.10.2
	virtual/mta"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack

	# If we're going to use the CFLAGS with GHC's -optc flag then we'd better
	# use it with -opta too or it'll break with some CFLAGS, eg -mcpu on sparc
	sed -i 's:\($(addprefix -optc,$(CFLAGS))\):\1 $(addprefix -opta,$(CFLAGS)):' \
		${S}/autoconf.mk.in

	# On ia64 we need to tone down the level of inlining so we don't break some
	# of the low level ghc/gcc interaction gubbins.
	use ia64 && sed -i 's/-funfolding-use-threshold20//' "${S}/GNUmakefile"
}

src_compile() {
	econf $(use_with doc docs) \
		|| die "configure failed"
	emake all || die "make failed"
}

src_test() {
	make test
}

src_install() {
	make DESTDIR="${D}" installbin || die "installation failed"
	# The bash completion should be installed in /usr/share/bash-completion/
	# rather than /etc/bash_completion.d/ . Fixes bug #148038.
	dodir "/usr/share/bash-completion" && \
		insinto "/usr/share/bash-completion" && \
		doins "/etc/bash_completion.d/darcs" && \
		   rm "${D}/etc/bash_completion.d/darcs" && \
		   rmdir "${D}/etc/bash_completion.d" && rmdir "${D}/etc" \
		|| die "fixing location of darcs bash completion failed"
	if use doc; then
		dodoc "${S}/darcs.ps"
		dohtml -r "${S}/manual/"*
	fi
}

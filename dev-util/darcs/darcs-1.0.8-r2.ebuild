# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-1.0.8-r2.ebuild,v 1.1 2007/06/07 20:48:46 kolmodin Exp $

inherit base autotools eutils

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
MY_P0="${P/_rc/rc}"
MY_P="${MY_P0/_pre/pre}"
SRC_URI="http://abridgegame.org/darcs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=net-misc/curl-7.10.2
	dev-haskell/html
	dev-haskell/mtl
	dev-haskell/quickcheck
	>=virtual/ghc-6.2.2
	doc?  ( virtual/tetex
			>=dev-tex/latex2html-2002.2.1_pre20041025-r1 )"

RDEPEND=">=net-misc/curl-7.10.2
	virtual/mta
	dev-libs/gmp"

S=${WORKDIR}/${MY_P}

src_unpack() {
	base_src_unpack

	cd "${S}"
	epatch "${FILESDIR}/${P}-ghc66.patch"
	epatch "${FILESDIR}/${PN}-1.0.9-bashcomp.patch"

	# If we're going to use the CFLAGS with GHC's -optc flag then we'd better
	# use it with -opta too or it'll break with some CFLAGS, eg -mcpu on sparc
	sed -i 's:\($(addprefix -optc,$(CFLAGS))\):\1 $(addprefix -opta,$(CFLAGS)):' \
		${S}/autoconf.mk.in

	# On ia64 we need to tone down the level of inlining so we don't break some
	# of the low level ghc/gcc interaction gubbins.
	use ia64 && sed -i 's/-funfolding-use-threshold20//' "${S}/GNUmakefile"
}

src_compile() {
	# Since we've patched the build system:
	eautoreconf

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
	insinto "/usr/share/bash-completion" \
		&& doins "${D}/etc/bash_completion.d/darcs" \
		&& rm    "${D}/etc/bash_completion.d/darcs" \
		&& rmdir "${D}/etc/bash_completion.d" \
		&& rmdir "${D}/etc" \
		|| die "fixing location of darcs bash completion failed"
	if use doc; then
		dodoc "${S}/darcs.ps"
		dohtml -r "${S}/manual/"*
	fi
}

pkg_postinst() {
	ewarn "NOTE: in order for the darcs send command to work properly,"
	ewarn "you must properly configure your mail transport agent to relay"
	ewarn "outgoing mail.  For example, if you are using ssmtp, please edit"
	ewarn "/etc/ssmtp/ssmtp.conf with appropriate values for your site."
}

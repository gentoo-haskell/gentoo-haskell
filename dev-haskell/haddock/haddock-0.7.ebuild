# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haddock/haddock-0.7.ebuild,v 1.14 2006/10/12 23:48:31 dcoutts Exp $
#
# USE variable summary:
#	doc	   - Build extra documenation from DocBook sources,
#				in HTML format.
#	java   - Build the above docs as PostScript as well.


inherit ghc-package multilib eutils
IUSE="doc"
#java use flag disable, bug #107019

DESCRIPTION="A documentation tool for Haskell"
SRC_URI="http://www.haskell.org/haddock/${P}-src.tar.gz"
HOMEPAGE="http://www.haskell.org/haddock"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
LICENSE="as-is"

DEPEND="doc? ( ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2
		>=dev-haskell/haddock-0.6-r2 )
		dev-haskell/network"
#		java? ( >=dev-java/fop-0.20.5 ) )"
RDEPEND=""

pkg_setup() {
	if ! has_version dev-lang/ghc; then
		eerror "Due to a bug in the portage dependency resolution, emerge"
		eerror "sometimes tries to merge haddock before a version of ghc"
		eerror "is available on the system. This is usually triggered when"
		eerror "you try to bootstrap ghc on a system with USE=\"doc\" using"
		eerror "the command"
		eerror
		eerror "   emerge ghc"
		eerror
		eerror "To resolve this problem, proceed in two steps. First, emerge"
		eerror "haddock (which should first pull in ghc-bin). Second, emerge"
		eerror "ghc again:"
		eerror
		eerror "   emerge haddock"
		eerror "   emerge ghc"
		die "portage dependency problem"
	fi
}

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-network.patch"
}

src_compile() {
	local myconf
	local mydoc

	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk
	# determine what to do with documentation
	if use doc; then
		mydoc="html"
		#if use java; then
		#	mydoc="${mydoc} ps"
		#fi
	else
		mydoc=""
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi
	echo XMLDocWays="${mydoc}" >> mk/build.mk

	econf || die "econf failed"

	# using -j1 because -j2 behaved strangely on my machine
	emake -j1 || die "make failed"
}

src_install() {
	local insttarget
	insttarget="install"
	use doc && insttarget="${insttarget} install-docs"

	# the libdir0 setting is needed for amd64, and does not
	# harm for other arches
	emake -j1 ${insttarget} \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/${P}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" \
		libdir0="${D}/usr/$(get_libdir)" \
		|| die "make install failed"

	cd ${S}/haddock
	dodoc CHANGES LICENSE README TODO
}

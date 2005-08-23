# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.4.ebuild,v 1.8 2005/08/17 14:41:32 dcoutts Exp $

# We abandon virtual/ghc in favor of || dependencies.
# Here's a brief explanation of the new bootstrap logic:
#
# ghc requires ghc-bin to bootstrap.
# Therefore, 
# (1) ghc depends on || (ghc-bin ghc)
# (2) all packages that need ghc do the same
#
# Having the binary first everywhere doesn't force
# anyone to do the full bootstrap. Still, ghc-bin can
# be removed from a system after the first successful
# install of ghc.

inherit base flag-o-matic eutils ghc-package

IUSE="doc java opengl"

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

# discover if this is a snapshot release
IS_SNAPSHOT="${PV%%*pre*}" # zero if snapshot
MY_PV="${PV/_pre/.}"
MY_P="${PN}-${MY_PV}"
EXTRA_SRC_URI="${MY_PV}"
[[ -z "${IS_SNAPSHOT}" ]] && EXTRA_SRC_URI="stable/dist"

SRC_URI="http://www.haskell.org/ghc/dist/${EXTRA_SRC_URI}/${MY_P}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
# re-add ~ppc64 once dependencies are fulfilled
KEYWORDS="-alpha ~amd64 ~ppc ~sparc ~x86"

S="${WORKDIR}/${MY_P}"

# we still provide virtual/ghc to maintain compatibility for now
PROVIDE="virtual/ghc"

# ghc cannot usually be bootstrapped using later versions ...
DEPEND="|| ( <=dev-lang/ghc-bin-6.5 <=dev-lang/ghc-6.5 )
	>=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=sys-devel/make-3.79.1
	>=sys-apps/sed-3.02.80
	>=sys-devel/flex-2.5.4a
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-4.2
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2
		>=dev-haskell/haddock-0.6-r2
		java? ( >=dev-java/fop-0.20.5 ) )
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )"

RDEPEND="virtual/libc
	>=sys-devel/gcc-2.95.3
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-4.2
	opengl? ( virtual/opengl virtual/glu virtual/glut )"

SUPPORTED_CFLAGS=""

# Setup supported CFLAGS.
check_cflags() {
	OLD_CFLAGS="${CFLAGS}"
	CFLAGS="$1"
	strip-unsupported-flags
	SUPPORTED_CFLAGS="${SUPPORTED_CFLAGS} ${CFLAGS}"
	CFLAGS="${OLD_CFLAGS}"
}

setup_cflags() {
	check_cflags "-nopie -fno-stack-protector -fno-stack-protector-all"
}

# Portage's resolution of virtuals fails on virtual/ghc in some Portage releases,
# the following function causes the build to fail with an informative error message
# in such a case.
# pkg_setup() {
# 	if ! has_version virtual/ghc; then
# 		eerror "This ebuild needs a version of GHC to bootstrap from."
# 		eerror "Please emerge dev-lang/ghc-bin to get a binary version."
# 		eerror "You can either use the binary version directly or emerge"
# 		eerror "dev-lang/ghc afterwards."
# 		die "virtual/ghc version required to build"
# 	fi
# }

src_unpack() {
	base_src_unpack

	if use ppc64; then
		epatch "${FILESDIR}/ghc-6.4-powerpc.patch"
	fi

	cd "${S}"
	epatch "${FILESDIR}/${PN}-6.4-nocabal.patch"
	rm "${S}"/ghc/lib/compat/System/Directory/Internals*

	# hardened-gcc needs to be disabled, because the
	# mangler doesn't accept its output; yes, the 6.2 version
	# should do ...
	cd "${S}/ghc"
	pushd driver
	setup_cflags

	epatch "${FILESDIR}/${PN}-6.2.hardened.patch"
	sed -i -e "s|@GHC_CFLAGS@|${SUPPORTED_CFLAGS// -/ -optc-}|" ghc/ghc.sh
	sed -i -e "s|@GHC_CFLAGS@|${SUPPORTED_CFLAGS// -/ -optc-}|" ghci/ghci.sh
	popd

	cd docs/users_guide/
	# use versionator or something
	# epatch "${FILESDIR}/ghc-6.4-docbook.patch"

	cd "${S}/libraries"
	sed -i -e "s|I/O|I\\\\/O|" template-haskell/Language/Haskell/TH/Syntax.hs
}

src_compile() {
	local myconf
	local mydoc

	if use opengl; then
		myconf="--enable-hopengl"
	fi

	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# determine what to do with documentation
	if use doc; then
		mydoc="html"
		if use java; then
			mydoc="${mydoc} ps"
		fi
	else
		mydoc=""
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi
	echo XMLDocWays="${mydoc}" >> mk/build.mk

	# disable the automatic PIC building which is considered as Prologue Junk by the Haskell Compiler
	# thanks to Peter Simons for finding this and giving notice on bugs.gentoo.org
	# (this is still necessary, even though we have the patch, because
	# we might be bootstrapping from a version that didn't have the
	# patch included)
	setup_cflags
	echo "SRC_CC_OPTS+=${SUPPORTED_CFLAGS}" >> mk/build.mk
	echo "SRC_HC_OPTS+=${SUPPORTED_CFLAGS// -/ -optc-}" >> mk/build.mk

	# force the config variable ArSupportsInput to be unset;
	# ar in binutils >= 2.14.90.0.8-r1 seems to be classified
	# incorrectly by the configure script
	echo "ArSupportsInput:=" >> mk/build.mk

	# Required for some architectures, because they don't support ghc fully ...
	use ppc || use ppc64 || use amd64 && echo "SplitObjs=NO" >> mk/build.mk
	use amd64 || use ppc64 && echo "GhcWithInterpreter=NO" >> mk/build.mk

	# (--enable-threaded-rts is no longer needed)
	econf ${myconf} || die "econf failed"

	# the build does not seem to work all that
	# well with parallel make
	emake -j1 all || die "make failed"

}

src_install () {
	local insttarget

	insttarget="install"
	use doc && insttarget="${insttarget} install-docs"

	# the libdir0 setting is needed for amd64, and does not
	# harm for other arches
	emake -j1 ${insttarget} \
		prefix="${D}/usr" \
		datadir="${D}/usr/share/doc/${PF}" \
		infodir="${D}/usr/share/info" \
		mandir="${D}/usr/share/man" \
		libdir0="${D}/usr/$(get_libdir)" \
		|| die "make ${insttarget} failed"

	#need to remove ${D} from ghcprof script
	cd "${D}/usr/bin"
	mv ghcprof ghcprof-orig
	sed -e 's:$FPTOOLS_TOP_ABS:#$FPTOOLS_TOP_ABS:' ghcprof-orig > ghcprof
	chmod a+x ghcprof
	rm -f ghcprof-orig

	cd "${S}/ghc"
	dodoc README ANNOUNCE LICENSE VERSION

	dosbin ${FILESDIR}/ghc-updater
}

pkg_postinst () {
	ebegin "Unregistering ghc's built-in cabal "
	$(ghc-getghcpkg) unregister Cabal > /dev/null
	eend $?
	ghc-reregister
	einfo "If you have dev-lang/ghc-bin installed, you might"
	einfo "want to unmerge it. It is no longer needed."
	einfo
	ewarn "IMPORTANT:"
	ewarn "If you upgrade from another ghc version, please run"
	ewarn "/usr/sbin/ghc-updater to re-merge all ghc-based"
	ewarn "Haskell libraries."
}


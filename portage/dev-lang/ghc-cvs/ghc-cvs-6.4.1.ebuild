# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc/ghc-6.4.ebuild,v 1.1 2005/03/11 16:30:24 kosmikus Exp $

# THIS IS AN UNOFFICIAL EBUILD. PLEASE CONTACT kosmikus@gentoo.org DIRECTLY
# IF YOU EXPERIENCE PROBLEMS. PLEASE DO NOT WRITE TO GENTOO-MAILING LISTS
# AND DON'T FILE ANY BUGS IN BUGZILLA ABOUT THIS BUILD.

# Brief explanation of the bootstrap logic:
#
# ghc requires ghc-bin to bootstrap.
# Therefore, 
# (1) both ghc-bin and ghc provide virtual/ghc
# (2) virtual/ghc *must* default to ghc-bin
# (3) ghc depends on virtual/ghc
#
# This solution has the advantage that the binary distribution
# can be removed once an forall after the first succesful install
# of ghc.

inherit base cvs flag-o-matic eutils ghc-package

ECVS_SERVER="cvs.haskell.org:/cvs"
ECVS_ANON="no"
ECVS_USER="anoncvs"
ECVS_AUTH="pserver"
# ECVS_RUNAS="portage"
# ECVS_RUNAS="`whoami`"
ECVS_PASS="cvs"
ECVS_MODULE="fptools"
ECVS_BRANCH="ghc-6.4-branch"

IUSE="doc java opengl"

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc -alpha ~amd64 -sparc"

S="${WORKDIR}/fptools"

# We don't provide virtual/ghc, although we could ...
# PROVIDE="virtual/ghc"

DEPEND="${DEPEND}
	virtual/ghc
	>=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=sys-devel/make-3.79.1
	>=sys-apps/sed-3.02.80
	>=sys-devel/flex-2.5.4a
	>=dev-libs/gmp-4.1
	>=dev-haskell/happy-1.15
        >=dev-haskell/alex-2.0
	>=sys-libs/readline-4.2
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
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

# save original (vanilla) options
ORIG_ECVS_CVS_OPTIONS=${ECVS_CVS_OPTIONS}

fetch_subdir() {
	ECVS_MODULE="$1"
	ECVS_CVS_OPTIONS=${ORIG_ECVS_CVS_OPTIONS}
	unset ECVS_LOCAL
	cvs_src_unpack
}

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

pkg_setup() {
	if ! has_version virtual/ghc; then
		eerror "This ebuild needs a version of GHC to bootstrap from."
		eerror "Please emerge dev-lang/ghc-bin to get a binary version."
		eerror "You can either use the binary version directly or emerge"
		eerror "dev-lang/ghc afterwards."
		die "virtual/ghc version required to build"
	fi
}

src_unpack() {
	# selectively fetch the subdirs needed to compile ghc
	fetch_subdir "fptools/ghc"
	fetch_subdir "fptools/hslibs"
	fetch_subdir "fptools/libraries"
	fetch_subdir "fptools/mk"
	fetch_subdir "fptools/glafp-utils"
	# get fptools directory non-recursively
	ECVS_MODULE="fptools"
	ECVS_LOCAL="yes"
	cvs_src_unpack

	# hardened-gcc needs to be disabled, because the
	# mangler doesn't accept its output; yes, the 6.2 version
	# should do ...
	cd ${S}/ghc
	pushd driver
	setup_cflags

	epatch ${FILESDIR}/${PN}-6.2.hardened.patch
	sed -i -e "s|@GHC_CFLAGS@|${SUPPORTED_CFLAGS// -/ -optc-}|" ghc/ghc.sh
	sed -i -e "s|@GHC_CFLAGS@|${SUPPORTED_CFLAGS// -/ -optc-}|" ghci/ghci.sh
	popd

	# cd docs/users_guide/
	# use versionator or something
	# epatch ${FILESDIR}/ghc-6.4-docbook.patch

	# cd ${S}/libraries
	# sed -i -e "s|I/O|I\\\\/O|" template-haskell/Language/Haskell/TH/Syntax.hs
}

src_compile() {
	local myconf
        myconf=$(use_enable opengl hopengl)

	WANT_AUTOCONF=2.5 autoreconf || die "autoreconf failed in fptools"

	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# determine what to do with documentation
	if use doc; then
		mydoc="html"
		insttarget="${insttarget} install-docs"
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
	use ppc || use amd64 && echo "SplitObjs=NO" >> mk/build.mk
	use amd64 && echo "GhcUnregisterised=YES" >> mk/build.mk

	# (--enable-threaded-rts is no longer needed)
	econf ${myconf} || die "econf failed"

	# the build does not seem to work all that
	# well with parallel make
	emake -j1 all || die "make failed"

}

src_install () {
	local mydoc
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
	cd ${D}/usr/bin
	mv ghcprof ghcprof-orig
	sed -e 's:$FPTOOLS_TOP_ABS:#$FPTOOLS_TOP_ABS:' ghcprof-orig > ghcprof
	chmod a+x ghcprof
	rm -f ghcprof-orig

	#rename non-version-specific files
	nonvers=$(find -path "./*" -and -not -path "*${PV}*")
	nondef=""
	for f in ${nonvers}; do
		f=$(basename ${f})
		mv ${f} ${f}-cvs
		if test -e /usr/bin/${f}; then
			if test -L /usr/bin/${f} -a -e /usr/bin/${f}-cvs; then
				if diff -q "/usr/bin/${f}" "/usr/bin/${f}-cvs" > /dev/null; then
					# link seems to be okay, recreate to keep
					einfo "recreating link /usr/bin/${f} -> /usr/bin/${f}-cvs"
					dosym /usr/bin/${f}-cvs /usr/bin/{f}
					continue
				fi
			fi
			einfo "did not touch existing file /usr/bin/${f}"
			# presumably not our file, will not be unmerged
			nondef="${nondef} /usr/bin/${f}"
		else
			# interestingly, the file in question does not yet exist ...
			einfo "creating new link /usr/bin/${f} -> /usr/bin/${f}-cvs"
			dosym /usr/bin/${f}-cvs /usr/bin/${f}
		fi
	done
	if test -n "${nondef}"; then
		einfo "If you want to make the CVS version of GHC the default version,"
		einfo "you should create the following symbolic links:"
		for f in ${nondef}; do
			einfo "   ${f} -> ${f}-cvs"
		done
		einfo "Note that this is optional."
	fi

	cd ${S}/ghc
	dodoc README ANNOUNCE LICENSE VERSION
}


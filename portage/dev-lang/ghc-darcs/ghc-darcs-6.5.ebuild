# Copyright 1999-2006 Gentoo Foundation
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

GHC_REPOSITORY="http://darcs.haskell.org"
EDARCS_REPOSITORY="${GHC_REPOSITORY}/ghc"
EDARCS_GET_CMD="get --partial"

inherit base eutils autotools darcs ghc-package check-reqs

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc X opengl openal"

# We don't provide virtual/ghc, although we could ...
# PROVIDE="virtual/ghc"

RDEPEND="
	>=sys-devel/gcc-2.95.3
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-4.2
	X? ( || ( x11-libs/libX11 virtual/x11 ) )
	opengl? ( virtual/opengl virtual/glu virtual/glut )
	openal? ( media-libs/openal )"

# ghc cannot usually be bootstrapped using later versions ...
DEPEND="${RDEPEND}
	<virtual/ghc-6.5
	!>=virtual/ghc-6.6
	>=dev-haskell/happy-1.15
	>=dev-haskell/alex-2.0
	doc? (  ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2
		>=dev-haskell/haddock-0.6-r2 )"
# removed: java? ( >=dev-java/fop-0.20.5 )

# hardened-gcc needs to be disabled, because the mangler doesn't accept
# its output.
GHC_CFLAGS="-optc-nopie -optl-nopie -optc-fno-stack-protector"

# We also add -opta-Wa,--noexecstack to get ghc to generate .o files with
# non-exectable stack. This it a hack until ghc does it itself properly.
GHC_CFLAGS="${GHC_CFLAGS} -opta-Wa,--noexecstack"

# The following function fetches each of the sub-repositories that
# ghc requires.
fetch_pkg() {
	local EDARCS_REPOSITORY EDARCS_LOCALREPO
	EDARCS_REPOSITORY="${GHC_REPOSITORY}/packages/$1"
	EDARCS_LOCALREPO="ghc/libraries/$1"
	darcs_fetch
}

src_unpack() {
	# get main GHC darcs repo
	darcs_fetch
	for pkg in $(cat "${EDARCS_TOP_DIR}/${EDARCS_LOCALREPO}/libraries/default-packages"); do
 		fetch_pkg "${pkg}"
	done
	# copy everything
	darcs_src_unpack

        # Modify the ghc driver script to use GHC_CFLAGS
        echo "SCRIPT_SUBST_VARS += GHC_CFLAGS" >> "${S}/ghc/driver/ghc/Makefile"
        echo "GHC_CFLAGS = ${GHC_CFLAGS}"      >> "${S}/ghc/driver/ghc/Makefile"
        sed -i -e 's|$TOPDIROPT|$TOPDIROPT $GHC_CFLAGS|' "${S}/ghc/driver/ghc/ghc.sh"
}

src_compile() {
	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# We also need to use the GHC_CFLAGS flags when building ghc itself
	echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
	echo "SRC_CC_OPTS+=-Wa,--noexecstack" >> mk/build.mk

	# If you need to do a quick build then enable this bit and add debug to IUSE
	#if use debug; then
	#	echo "SRC_HC_OPTS     = -H32m -O0 -fasm" >> mk/build.mk
	#	echo "GhcStage1HcOpts = -O0" >> mk/build.mk
	#	echo "GhcLibHcOpts    = -fgenerics" >> mk/build.mk
	#	echo "GhcLibWays      =" >> mk/build.mk
	#	echo "SplitObjs       = NO" >> mk/build.mk
	#fi

	# determine what to do with documentation
	local mydoc
	if use doc; then
		mydoc="html"
#		if use java; then
#			mydoc="${mydoc} ps"
#		fi
	else
		mydoc=""
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi
	echo XMLDocWays="${mydoc}" >> mk/build.mk

	# circumvent a very strange bug that seems related with ghc producing too much
	# output while being filtered through tee (e.g. due to portage logging)
	# reported as bug #111183
	echo "SRC_HC_OPTS+=-fno-warn-deprecations" >> mk/build.mk

	# force the config variable ArSupportsInput to be unset;
	# ar in binutils >= 2.14.90.0.8-r1 seems to be classified
	# incorrectly by the configure script
	echo "ArSupportsInput:=" >> mk/build.mk

	# Required for some architectures, because they don't support ghc fully ...
	use alpha || use hppa && echo "GhcWithInterpreter=NO" >> mk/build.mk
	use alpha || use hppa && echo "GhcUnregisterised=YES" >> mk/build.mk

	# The SplitObjs feature doesn't work on several arches and it makes
	# 'ar' take loads of RAM:
	CHECKREQS_MEMORY="200"
	if use alpha || use hppa || use ppc64; then
		echo "SplitObjs=NO" >> mk/build.mk
	elif ! check_reqs_conditional; then
		einfo "Turning off ghc's 'Split Objs' feature because this machine"
		einfo "does not have enough RAM for it. This will have the effect"
		einfo "of making binaries produced by ghc considerably larger."
		echo "SplitObjs=NO" >> mk/build.mk
	fi

	# we've patched some configure.ac files do allow us to enable/disable the
	# X11 and HGL packages, so we need to autoreconf.
	eautoreconf

	# make sure that we can execute ./configure
	chmod u+x ./configure

	econf \
		$(use_enable opengl opengl) \
		$(use_enable opengl glut) \
		$(use_enable openal openal) \
		$(use_enable X x11) \
		$(use_enable X hgl) \
		|| die "econf failed"

	# the build does not seem to work all that
	# well with parallel make
	emake -j1 all datadir="/usr/share/doc/${PF}" || die "make failed"
	# the explicit datadir is required to make the haddock entries
	# in the package.conf file point to the right place ...

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


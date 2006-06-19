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

inherit base eutils cvs flag-o-matic toolchain-funcs autotools ghc-package check-reqs

ECVS_SERVER="cvs.haskell.org:/cvs"
ECVS_ANON="no"
ECVS_USER="anoncvs"
ECVS_AUTH="pserver"
# ECVS_RUNAS="portage"
# ECVS_RUNAS="`whoami`"
ECVS_PASS="cvs"
ECVS_MODULE="fptools"
ECVS_BRANCH="ghc-6-4-branch"

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test doc X opengl openal"

S="${WORKDIR}/fptools"

# We don't provide virtual/ghc, although we could ...
# PROVIDE="virtual/ghc"

RDEPEND="
	>=sys-devel/gcc-2.95.3
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-4.2
	X? ( || ( x11-libs/libX11 virtual/x11 ) )
	opengl? ( virtual/opengl
			  virtual/glu virtual/glut
			  openal? ( media-libs/openal ) )"

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

PDEPEND=">=dev-haskell/cabal-1.1.4"

# save original (vanilla) options
ORIG_ECVS_CVS_OPTIONS=${ECVS_CVS_OPTIONS}

fetch_subdir() {
	ECVS_MODULE="$1"
	ECVS_CVS_OPTIONS=${ORIG_ECVS_CVS_OPTIONS}
	unset ECVS_LOCAL
	cvs_src_unpack
}

append-ghc-cflags() {
	local flag compile assemble link
	for flag in $*; do
		case ${flag} in
			compile)	compile="yes";;
			assemble)	assemble="yes";;
			link)		link="yes";;
			*)
				[[ ${compile}  ]] && GHC_CFLAGS="${GHC_CFLAGS} -optc${flag}"
				[[ ${assemble} ]] && GHC_CFLAGS="${GHC_CFLAGS} -opta${flag}"
				[[ ${link}     ]] && GHC_CFLAGS="${GHC_CFLAGS} -optl${flag}";;
		esac
	done
}

ghc_setup_cflags() {
	# We need to be very careful with the CFLAGS we ask ghc to pass through to
	# gcc. There are plenty of flags which will make gcc produce output that
	# breaks ghc in various ways. The main ones we want to pass through are
	# -mcpu / -march flags. These are important for arches like alpha & sparc.
	# We also use these CFLAGS for building the C parts of ghc, ie the rts.
	strip-flags
	strip-unsupported-flags
	filter-flags -fPIC

	GHC_CFLAGS=""
	for flag in ${CFLAGS}; do
		case ${flag} in

			# Ignore extra optimisation (ghc passes -O to gcc anyway)
			# -O2 and above break on too many systems
			-O*) ;;

			# Arch and ABI flags are what we're really after
			-m*) append-ghc-cflags compile assemble ${flag};;

			# Debugging flags don't help either. You can't debug Haskell code
			# at the C source level and the mangler discards the debug info.
			-g*) ;;

			# Ignore all other flags, including all -f* flags
		esac
	done

	# hardened-gcc needs to be disabled, because the mangler doesn't accept
	# its output.
	gcc-specs-pie && append-ghc-cflags compile link	-nopie
	gcc-specs-ssp && append-ghc-cflags compile		-fno-stack-protector

	# We also add -Wa,--noexecstack to get ghc to generate .o files with
	# non-exectable stack. This it a hack until ghc does it itself properly.
	append-ghc-cflags assemble		"-Wa,--noexecstack"
}

ghc_setup_wrapper() {
	echo '#!/bin/sh'
	echo "GHCBIN=\"$(ghc-libdir)/ghc-$1\";"
	echo "TOPDIROPT=\"-B$(ghc-libdir)\";"
	echo "GHC_CFLAGS=\"${GHC_CFLAGS}\";"
	echo '# Mini-driver for GHC'
	echo 'exec $GHCBIN $TOPDIROPT $GHC_CFLAGS ${1+"$@"}'
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

	# Modify the ghc driver script to use GHC_CFLAGS
	echo "SCRIPT_SUBST_VARS += GHC_CFLAGS" >> "${S}/ghc/driver/ghc/Makefile"
	echo "GHC_CFLAGS = ${GHC_CFLAGS}"      >> "${S}/ghc/driver/ghc/Makefile"
	sed -i -e 's|$TOPDIROPT|$TOPDIROPT $GHC_CFLAGS|' "${S}/ghc/driver/ghc/ghc.sh"

	# If we're using the testsuite then move it to into the build tree
	use test && mv "${WORKDIR}/testsuite" "${S}/"

	# This is a hack for ia64. We can persuade ghc to avoid mangler errors
	# if we turn down the optimisations in one problematic module.
	use ia64 && sed -i -e 's/OPTIONS_GHC/OPTIONS_GHC -O0 -optc-O/' \
		"${S}/libraries/base/GHC/Float.lhs"
}

src_compile() {
	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# We also need to use the GHC_CFLAGS flags when building ghc itself
	echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
	echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk

	# If you need to do a quick build then enable this bit and add debug to IUSE
	#if use debug; then
	#	echo "SRC_HC_OPTS     = -H32m -O0" >> mk/build.mk
	#	echo "GhcStage1HcOpts =" >> mk/build.mk
	#	echo "GhcLibHcOpts    =" >> mk/build.mk
	#	echo "GhcLibWays      =" >> mk/build.mk
	#	echo "SplitObjs       = NO" >> mk/build.mk
	#fi

	# determine what to do with documentation
	if use doc; then
		echo XMLDocWays="html" >> mk/build.mk
	else
		echo XMLDocWays="" >> mk/build.mk
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi

	# circumvent a very strange bug that seems related with ghc producing too much
	# output while being filtered through tee (e.g. due to portage logging)
	# reported as bug #111183
	echo "SRC_HC_OPTS+=-fno-warn-deprecations" >> mk/build.mk

	# force the config variable ArSupportsInput to be unset;
	# ar in binutils >= 2.14.90.0.8-r1 seems to be classified
	# incorrectly by the configure script
	echo "ArSupportsInput:=" >> mk/build.mk

	# Some arches do support some ghc features even though they're off by default
	use ia64 && echo "GhcWithInterpreter=YES" >> mk/build.mk

	# The SplitObjs feature makes 'ar'/'ranlib' take loads of RAM:
	CHECKREQS_MEMORY="200"
	if ! check_reqs_conditional; then
		einfo "Turning off ghc's 'Split Objs' feature because this machine"
		einfo "does not have enough RAM for it. This will have the effect"
		einfo "of making binaries produced by ghc considerably larger."
		echo "SplitObjs=NO" >> mk/build.mk
	fi

	GHC_CFLAGS="" ghc_setup_wrapper $(ghc-version) > "${TMP}/ghc.sh"
	chmod +x "${TMP}/ghc.sh"

	# We've patched some configure.ac files to fix the OpenAL/ALUT bindings.
	# So we need to autoreconf.
	eautoreconf

	econf \
		--with-ghc="${TMP}/ghc.sh" \
		$(use_enable opengl opengl) \
		$(use_enable opengl glut) \
		$(use openal && use opengl \
			&& echo --enable-openal --enable-alut \
			|| echo --disable-openal --disable-alut) \
		$(use_enable X x11) \
		$(use_enable X hgl) \
		|| die "econf failed"

	emake all datadir="/usr/share/doc/${PF}" || die "make failed"
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
	# TODO: does this actually work?
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

	cd "${S}/ghc"
	dodoc README ANNOUNCE LICENSE VERSION
}

src_test() {
	if use test; then
		local summary
		summary="${TMP}/testsuite-summary.txt"

		make -C "${S}/testsuite/" boot || die "Preparing the testsuite failed"
		make -C "${S}/testsuite/tests/ghc-regress" \
				TEST_HC="${S}/ghc/compiler/stage2/ghc-inplace" \
				EXTRA_RUNTEST_OPTS="--output-summary=${summary}"

		if grep -q ' 0 unexpected failures' "${summary}"; then
			einfo "All tests passed ok"
		else
			ewarn "Some tests failed, for a summary see: ${summary}"
		fi
	else
		ewarn "Sadly, due to some portage limitations you need both"
		ewarn "USE=test and FEATURES=test to run the ghc testsuite"
	fi
}


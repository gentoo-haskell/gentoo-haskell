# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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

# Note to users of hardened gcc-3.x:
#
# If you emerge ghc with hardened gcc it should work fine (because we
# turn off the hardened features that would otherwise break ghc).
# However, emerging ghc while using a vanilla gcc and then switching to
# hardened gcc (using gcc-config) will leave you with a broken ghc. To
# fix it you would need to either switch back to vanilla gcc or re-emerge
# ghc (or ghc-bin). Note that also if you are using hardened gcc-3.x and
# you switch to gcc-4.x that this will also break ghc and you'll need to
# re-emerge ghc (or ghc-bin). People using vanilla gcc can switch between
# gcc-3.x and 4.x with no problems.

inherit base eutils flag-o-matic toolchain-funcs ghc-package

DESCRIPTION="The Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"

SRC_URI="http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ppc sparc x86"
IUSE="doc opengl"

PROVIDE="virtual/ghc"

RDEPEND="
	<sys-devel/gcc-4
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	>=sys-libs/readline-4.2
	opengl? ( virtual/opengl
			  virtual/glu virtual/glut )"

# ghc cannot usually be bootstrapped using later versions ...
DEPEND="${RDEPEND}
	<virtual/ghc-6.3
	!>=virtual/ghc-6.4
	doc? (  ~app-text/docbook-sgml-dtd-3.1
			>=app-text/docbook-dsssl-stylesheets-1.64
			>=app-text/openjade-1.3.1
			>=app-text/sgml-common-0.6.3
			>=dev-haskell/haddock-0.6-r2 )"

pkg_setup() {
	if test $(gcc-major-version) -gt 3; then
		eerror "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
		eerror "You can either use gcc-config to switch to gcc-3.x"
		eerror "or you emerge '>=dev-lang/ghc-6.4' or later."
		die "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
	fi
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
	base_src_unpack
	ghc_setup_cflags

	# Modify the ghc driver script to use GHC_CFLAGS
	echo "SCRIPT_SUBST_VARS += GHC_CFLAGS" >> "${S}/ghc/driver/ghc/Makefile"
	echo "GHC_CFLAGS = ${GHC_CFLAGS}"      >> "${S}/ghc/driver/ghc/Makefile"
	sed -i -e 's|$TOPDIROPT|$TOPDIROPT $GHC_CFLAGS|' "${S}/ghc/driver/ghc/ghc.sh"

	# Patch to fix a mis-compilation in the rts due to strict aliasing,
	# should be fixed upstream for 6.4.3 and 6.6. Fixes bug #135651.
	echo 'GC_HC_OPTS += -optc-fno-strict-aliasing' >> "${S}/ghc/rts/Makefile"

	# Don't strip binaries on install. See QA warnings in bug #140369.
	sed -i -e 's/SRC_INSTALL_BIN_OPTS	+= -s//' ${S}/mk/config.mk.in
}

src_compile() {
	# initialize build.mk
	echo '# Gentoo changes' > mk/build.mk

	# We also need to use the GHC_CFLAGS flags when building ghc itself
	echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
	echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk

	# determine what to do with documentation
	if use doc; then
		echo SGMLDocWays="html" >> mk/build.mk
	else
		echo SGMLDocWays="" >> mk/build.mk
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk
	fi

	# circumvent a very strange bug that seems related with ghc producing too much
	# output while being filtered through tee (e.g. due to portage logging)
	# reported as bug #111183
	echo "SRC_HC_OPTS+=-fno-warn-deprecations" >> mk/build.mk

	# Required for some architectures, because they don't support ghc fully ...
	use ppc || use sparc && echo "SplitObjs=NO" >> mk/build.mk
	use sparc && echo "GhcWithInterpreter=NO" >> mk/build.mk

	GHC_CFLAGS="" ghc_setup_wrapper $(ghc-version) > "${T}/ghc.sh"
	chmod +x "${T}/ghc.sh"

	# unset SGML_CATALOG_FILES because documentation installation
	# breaks otherwise ...
	SGML_CATALOG_FILES="" econf \
		--with-ghc="${T}/ghc.sh" \
		$(use_enable opengl hopengl) \
		|| die "econf failed"

	# ghc-6.2.x build system does not support parallel make
	emake -j1 datadir="/usr/share/doc/${PF}" || die "make failed"
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

	cd "${S}/ghc"
	dodoc README ANNOUNCE LICENSE VERSION

	dosbin ${FILESDIR}/ghc-updater
}

pkg_postinst () {
	ghc-reregister
	elog "If you have dev-lang/ghc-bin installed, you might"
	elog "want to unmerge it. It is no longer needed."
	elog
	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc or"
	ewarn "if you have switched from ghc-bin to ghc, please run:"
	ewarn "	/usr/sbin/ghc-updater"
	ewarn "to re-merge all ghc-based Haskell libraries."
}


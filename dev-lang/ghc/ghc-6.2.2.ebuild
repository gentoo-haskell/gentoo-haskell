# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Brief explanation of the bootstrap logic:
#
# Previous ghc ebuilds have been split into two: ghc and ghc-bin,
# where ghc-bin was primarily used for bootstrapping purposes.
# From now on, these two ebuilds have been combined, with the
# binary USE flag used to determine whether or not the pre-built
# binary package should be emerged or whether ghc should be compiled
# from source.  If the latter, then the relevant ghc-bin for the
# arch in question will be used in the working directory to compile
# ghc from source.
#
# This solution has the advantage of allowing us to retain the one
# ebuild for both packages, and thus phase out virtual/ghc.

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

SRC_URI="http://haskell.org/ghc/dist/${PV}/ghc-${PV}-src.tar.bz2
		 ppc?	( mirror://gentoo/ghc-bin-${PV}-r1-ppc.tbz2 )
		 sparc?	( mirror://gentoo/ghc-bin-${PV}-r1-sparc.tbz2 )
		 x86?	( mirror://gentoo/ghc-bin-${PV}-r1-x86.tbz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ppc sparc x86"
IUSE="binary doc ghcbootstrap opengl"

LOC="/opt/ghc" # location for installation of binary version

PROVIDE="virtual/ghc"

RDEPEND="
	>=sys-devel/gcc-2.95.3
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	=sys-libs/readline-5*
	opengl? ( virtual/opengl
			  virtual/glu virtual/glut )"

DEPEND="${RDEPEND}
	doc? (  ~app-text/docbook-sgml-dtd-3.1
			>=app-text/docbook-dsssl-stylesheets-1.64
			>=app-text/openjade-1.3.1
			>=app-text/sgml-common-0.6.3
			>=dev-haskell/haddock-0.6-r2 )"

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
	echo "GHCBIN=\"$1\";"
	echo "TOPDIROPT=\"-B$(dirname $1)\";"
	echo "GHC_CFLAGS=\"${GHC_CFLAGS}\";"
	echo '# Mini-driver for GHC'
	echo 'exec $GHCBIN $TOPDIROPT $GHC_CFLAGS ${1+"$@"}'
}

pkg_setup() {
	if test $(gcc-major-version) -gt 3; then
		eerror "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
		eerror "You can either use gcc-config to switch to gcc-3.x"
		eerror "or you emerge '>=dev-lang/ghc-6.4' or later."
		die "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
	fi

	if use ghcbootstrap && [[ -z $(type -P ghc) ]]; then
		ewarn ""
		ewarn "You requested bootstrapping,"
		ewarn "but I could not find a ghc executable to bootstrap with"
		ewarn ""
		die "Could not find a ghc executable to bootstrap with"
	fi

	if use binary; then
		if use opengl || use doc; then
			ewarn "The binary build does not include the docs or OpenGL bindings"
			ewarn "If you want those features, emerge with USE=\"-binary\""
		fi
	fi
}

src_unpack() {
	# Create the ${S} dir if we're using the binary version
	use binary && mkdir "${S}"

	base_src_unpack
	ghc_setup_cflags

	if use binary; then

		# Move unpacked files to the expected place
		mv "${WORKDIR}/usr" "${S}"

		if use doc; then
			mkdir "${S}/usr/share/doc/${MY_P}/html"
			mv "${WORKDIR}/libraries" "${S}/usr/share/doc/${MY_P}/html/"
			mv "${WORKDIR}/users_guide" "${S}/usr/share/doc/${MY_P}/html/"
		fi

		# Setup the ghc wrapper script
		GHCBIN="${LOC}/$(get_libdir)/$P/$P"
		ghc_setup_wrapper "$GHCBIN" > "${S}/usr/bin/ghc-${PV}"

		# Relocate from /usr to /opt/ghc
		sed -i -e "s|/usr|${LOC}|g" \
			"${S}/usr/bin/ghci-${PV}" \
			"${S}/usr/bin/ghc-pkg-${PV}" \
			"${S}/usr/bin/hsc2hs" \
			"${S}/usr/$(get_libdir)/ghc-${PV}/package.conf"

		sed -i -e "s|/usr/$(get_libdir)|${LOC}/$(get_libdir)|" \
			"${S}/usr/bin/ghcprof"

	else
		# Modify the ghc driver script to use GHC_CFLAGS
		echo "SCRIPT_SUBST_VARS += GHC_CFLAGS" >> "${S}/ghc/driver/ghc/Makefile"
		echo "GHC_CFLAGS = ${GHC_CFLAGS}"      >> "${S}/ghc/driver/ghc/Makefile"
		sed -i -e 's|$TOPDIROPT|$TOPDIROPT $GHC_CFLAGS|' "${S}/ghc/driver/ghc/ghc.sh"

		# Create the setup wrapper
		if use ghcbootstrap; then
			# When we are bootstrapping, rely on the developer to have set a
			# sane environment

			echo -e '#!/bin/sh\nexec ghc $*' > "${T}/ghc.sh"
		else
			GHC_TOP="${WORKDIR}/usr/$(get_libdir)/${P}"
			GHC_CFLAGS="" ghc_setup_wrapper "${GHC_TOP}/${P}" > "${T}/ghc.sh"

			# Fix paths for workdir ghc
			sed -i -e "s|/usr|${WORKDIR}/usr|g" \
				"${GHC_TOP}/package.conf"
		fi

		chmod +x "${T}/ghc.sh"

		# Patch to fix a mis-compilation in the rts due to strict aliasing,
		# should be fixed upstream for 6.4.3 and 6.6. Fixes bug #135651.
		echo 'GC_HC_OPTS += -optc-fno-strict-aliasing' >> "${S}/ghc/rts/Makefile"

		# Don't strip binaries on install. See QA warnings in bug #140369.
		sed -i -e 's/SRC_INSTALL_BIN_OPTS	+= -s//' ${S}/mk/config.mk.in
	fi
}

src_compile() {
	if ! use binary; then

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
		# TODO: is this still required ?

	fi # ! use binary
}

src_install () {
	if use binary; then
		mkdir "${D}/opt"
		mv "${S}/usr" "${D}/opt/ghc"

		doenvd "${FILESDIR}/10ghc"
	else
		local insttarget

		insttarget="install"
		use doc && insttarget="${insttarget} install-docs"

		# the libdir0 setting is needed for amd64, and does not
		# harm for other arches
		#TODO: is this still required?
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
	fi
}

pkg_postinst () {
	ghc-reregister
	elog "If you have dev-lang/ghc-bin installed, you might"
	elog "want to unmerge it. It is no longer needed."
	elog

	if use binary; then
		elog "The envirenment has been set to use the binary distribution of"
		elog "GHC. In order to activate it please run:"
		elog "   env-update && source /etc/profile"
		elog "Otherwise this setting will become active the next time you login"
	fi

	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc or"
	ewarn "if you have switched between binary and source versions"
	ewarn "of ghc, please run:"
	if use binary; then
		ewarn "      /opt/ghc/sbin/ghc-updater"
	else
		ewarn "      /usr/sbin/ghc-updater"
	fi
	ewarn "to re-merge all ghc-based Haskell libraries."
}


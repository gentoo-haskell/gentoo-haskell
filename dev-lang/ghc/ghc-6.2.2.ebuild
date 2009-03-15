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

SRC_URI="!binary? ( http://haskell.org/ghc/dist/${PV}/${P}-src.tar.bz2 )
		 doc? 	( mirror://gentoo/${P}-libraries.tar.gz
				  mirror://gentoo/${P}-users_guide.tar.gz )
		 ppc?	( mirror://gentoo/ghc-bin-${PV}-r1-ppc.tbz2 )
		 sparc?	( mirror://gentoo/ghc-bin-${PV}-r1-sparc.tbz2 )
		 x86?	( mirror://gentoo/ghc-bin-${PV}-r1-x86.tbz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ppc sparc x86"
IUSE="binary doc ghcbootstrap opengl"

LOC="/opt/ghc" # location for installation of binary version

RDEPEND="
	!dev-lang/ghc-bin
	>=sys-devel/gcc-2.95.3
	>=sys-devel/binutils-2.17
	>=dev-lang/perl-5.6.1
	>=dev-libs/gmp-4.1
	=sys-libs/readline-5*
	opengl? ( virtual/opengl
			  virtual/glu virtual/glut )"

DEPEND="${RDEPEND}"
# In the ghcbootstrap case we rely on the developer having
# >=ghc-5.04.3 on their $PATH already

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

pkg_setup() {
	if test $(gcc-major-version) -gt 3; then
		eerror "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
		eerror "You can either use gcc-config to switch to gcc-3.x"
		eerror "or you emerge '>=dev-lang/ghc-6.4' or later."
		die "ghc-6.2.2 does not work with gcc-4.x, only 3.x or older"
	fi

	if use ghcbootstrap; then
		ewarn "You requested ghc bootstrapping, this is usually only used"
		ewarn "by Gentoo developers to make binary .tbz2 packages for"
		ewarn "use with the ghc ebuild's USE=\"binary\" feature."
		use binary && \
			die "USE=\"ghcbootstrap binary\" is not a valid combination."
		use doc && \
			die "USE=\"ghcbootstrap doc\" is not a valid combination"
		[[ -z $(type -P ghc) ]] && \
			die "Could not find a ghc to bootstrap with."
	fi

	if use binary; then
		if use opengl || use doc; then
			ewarn "The binary build does not include the docs or OpenGL bindings"
			ewarn "If you want those features, emerge with USE=\"-binary\""
		fi
	fi

	set_config
}

set_config() {
	# make this a separate function and call it several times as portage doesn't
	# remember the variables properly between the fuctions.
	use binary && GHC_PREFIX="/opt/ghc" || GHC_PREFIX="/usr"
}

src_unpack() {
	# Create the ${S} dir if we're using the binary version
	use binary && mkdir "${S}"

	base_src_unpack
	ghc_setup_cflags

	if use binary; then

		# Move unpacked files to the expected place
		mv "${WORKDIR}/usr" "${S}"

		# Relocate from /usr to /opt/ghc
		sed -i -e "s|/usr|${LOC}|g" \
			"${S}/usr/bin/ghc-${PV}" \
			"${S}/usr/bin/ghci-${PV}" \
			"${S}/usr/bin/ghc-pkg-${PV}" \
			"${S}/usr/bin/hsc2hs" \
			"${S}/usr/$(get_libdir)/${P}/package.conf" \
			|| die "Relocating ghc from /usr to /opt/ghc failed"

		sed -i -e "s|/usr/$(get_libdir)|${LOC}/$(get_libdir)|" \
			"${S}/usr/bin/ghcprof"

	else
		# Modify the ghc driver script to use GHC_CFLAGS
		echo "SCRIPT_SUBST_VARS += GHC_CFLAGS" >> "${S}/ghc/driver/ghc/Makefile"
		echo "GHC_CFLAGS = ${GHC_CFLAGS}"      >> "${S}/ghc/driver/ghc/Makefile"
		sed -i -e 's|$TOPDIROPT|$TOPDIROPT $GHC_CFLAGS|' "${S}/ghc/driver/ghc/ghc.sh"

		if ! use ghcbootstrap; then
			# Relocate from /usr to ${WORKDIR}/usr
			sed -i -e "s|/usr|${WORKDIR}/usr|g" \
				"${WORKDIR}/usr/bin/ghc-${PV}" \
				"${WORKDIR}/usr/bin/ghci-${PV}" \
				"${WORKDIR}/usr/bin/ghc-pkg-${PV}" \
				"${WORKDIR}/usr/bin/hsc2hs" \
				"${WORKDIR}/usr/$(get_libdir)/${P}/package.conf" \
				|| die "Relocating ghc from /usr to workdir failed"
		fi

		# Patch to fix a mis-compilation in the rts due to strict aliasing,
		# should be fixed upstream for 6.4.3 and 6.6. Fixes bug #135651.
		echo 'GC_HC_OPTS += -optc-fno-strict-aliasing' >> "${S}/ghc/rts/Makefile"

		# Don't strip binaries on install. See QA warnings in bug #140369.
		sed -i -e 's/SRC_INSTALL_BIN_OPTS	+= -s//' "${S}/mk/config.mk.in"
	fi
}

src_compile() {
	if ! use binary; then

		# initialize build.mk
		echo '# Gentoo changes' > mk/build.mk

		# We also need to use the GHC_CFLAGS flags when building ghc itself
		echo "SRC_HC_OPTS+=${GHC_CFLAGS}" >> mk/build.mk
		echo "SRC_CC_OPTS+=${CFLAGS} -Wa,--noexecstack" >> mk/build.mk

		# We can't depend on haddock so we never build docs
		# and we rely on pre-built ones instead
		echo SGMLDocWays="" >> mk/build.mk
		# needed to prevent haddock from being called
		echo NO_HADDOCK_DOCS=YES >> mk/build.mk

		# circumvent a very strange bug that seems related with ghc producing too much
		# output while being filtered through tee (e.g. due to portage logging)
		# reported as bug #111183
		echo "SRC_HC_OPTS+=-fno-warn-deprecations" >> mk/build.mk

		# Required for some architectures, because they don't support ghc fully ...
		use ppc || use sparc && echo "SplitObjs=NO" >> mk/build.mk
		use sparc && echo "GhcWithInterpreter=NO" >> mk/build.mk

		# Get ghc from the unpacked binary .tbz2
		# except when bootstrapping we just pick ghc up off the path
		use ghcbootstrap || \
			export PATH="${WORKDIR}/usr/bin:${PATH}"

		# Note that --disable-hopengl actually enables it. We have to ommit
		# the flag to disable opengl.
		econf \
			$(use opengl && echo "--enable-hopengl") \
			|| die "econf failed"

		# ghc-6.2.x build system does not support parallel make
		emake -j1 datadir="/usr/share/doc/${P}" || die "make failed"
		# the explicit datadir is required to make the haddock entries
		# in the package.conf file point to the right place ...

	fi # ! use binary
}

src_install() {
	if use binary; then
		mkdir "${D}/opt"
		mv "${S}/usr" "${D}/opt/ghc"

		cp -p "${D}/${GHC_PREFIX}/$(get_libdir)/${P}/package.conf"{,.shipped} \
			|| die "failed to copy package.conf"

		doenvd "${FILESDIR}/10ghc"
	else
		# the libdir0 setting is needed for amd64, and does not
		# harm for other arches
		#TODO: are any of these overrides still required? isn't econf enough?
		emake -j1 install \
			prefix="${D}/usr" \
			datadir="${D}/usr/share/doc/${PF}" \
			infodir="${D}/usr/share/info" \
			mandir="${D}/usr/share/man" \
			libdir0="${D}/usr/$(get_libdir)" \
			|| die "make install failed"

		cd "${S}/ghc"
		dodoc README ANNOUNCE LICENSE VERSION

		dosbin "${FILESDIR}/ghc-updater"

		cp -p "${D}/${GHC_PREFIX}/$(get_libdir)/${P}/package.conf"{,.shipped} \
			|| die "failed to copy package.conf"
	fi

	if use doc; then
		docinto "html/libraries"
		dohtml -A haddock -r "${WORKDIR}/libraries/"* \
			|| die "installing library docs failed"
		docinto "html/users_guide"
		dohtml -r "${WORKDIR}/users_guide/"* \
			|| die "installing user guide failed"
		docinto ""
	fi
}

pkg_postinst () {
	ghc-reregister

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

pkg_prerm() {
	# Overwrite the (potentially) modified package.conf with a copy of the
	# original one, so that it will be removed during uninstall.

	set_config # load GHC_PREFIX

	PKG="${ROOT}/${GHC_PREFIX}/$(get_libdir)/${P}/package.conf"

	cp -p "${PKG}"{.shipped,}

	[[ -f ${PKG}.old ]] && rm "${PKG}.old"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-6.4.2.ebuild,v 1.1 2006/05/03 22:38:28 dcoutts Exp $

inherit base multilib flag-o-matic toolchain-funcs ghc-package

DESCRIPTION="Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"
# list all arches for proper digest building:
SRC_URI="x86-fbsd?  ( mirror://gentoo/${P}-x86-fbsd.tbz2 )"

LICENSE="as-is"
KEYWORDS="-* ~x86-fbsd"
SLOT="0"
IUSE="" # use the non-binary version if you want to have more choice

RESTRICT="nostrip" # already stripped

LOC="/opt/ghc"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1
	=sys-libs/readline-5*"

PROVIDE="virtual/ghc"

S="${WORKDIR}"

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
	append-ghc-cflags assemble "-Wa,--noexecstack"
}

ghc_setup_wrapper() {
	echo '#!/bin/bash'
	echo "GHCBIN=\"${LOC}/$(get_libdir)/ghc-$1/ghc-$1\";"
	echo "TOPDIROPT=\"-B${LOC}/$(get_libdir)/ghc-$1\";"
	echo "GHC_CFLAGS=\"${GHC_CFLAGS}\";"
	echo '# Mini-driver for GHC'
	echo 'exec $GHCBIN $TOPDIROPT $GHC_CFLAGS ${1+"$@"}'
}

src_unpack() {
	base_src_unpack

	# Setup the ghc wrapper script
	ghc_setup_cflags
	ghc_setup_wrapper ${PV} > "${S}/usr/bin/ghc-${PV}"

	# Relocate from /usr to /opt/ghc
	sed -i -e "s|/usr|${LOC}|g" \
		"${S}/usr/bin/ghci-${PV}" \
		"${S}/usr/bin/ghc-pkg-${PV}" \
		"${S}/usr/bin/hsc2hs" \
		"${S}/usr/$(get_libdir)/ghc-${PV}/package.conf"

	sed -i -e "s|/usr/$(get_libdir)|${LOC}/$(get_libdir)|" \
		"${S}/usr/bin/ghcprof"
}

src_compile() {
	true
}

src_install () {
	mkdir "${D}/opt"
	mv "${S}/usr" "${D}/opt/ghc"

	insinto /etc/env.d
	doins "${FILESDIR}/10ghc"
}

pkg_postinst () {
	ghc-reregister
	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc-bin or"
	ewarn "if you have switched from ghc to ghc-bin, please run:"
	ewarn "	/opt/ghc/sbin/ghc-updater"
	ewarn "to re-merge all ghc-based Haskell libraries."
}

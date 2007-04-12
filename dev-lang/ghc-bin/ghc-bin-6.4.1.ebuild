# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base multilib ghc-package

DESCRIPTION="Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"
# list all arches for proper digest building:
SRC_URI="x86?  ( mirror://gentoo/${P}-x86.tbz2 )
		 amd64? ( mirror://gentoo/${P}-amd64.tbz2 )
		 alpha? ( mirror://gentoo/${P}-alpha.tbz2 )
		 hppa? ( mirror://gentoo/${P}-hppa.tbz2 )
		 sparc? ( mirror://gentoo/${P}-sparc.tbz2 )
		 ppc? ( mirror://gentoo/${P}-ppc.tbz2 )
		 ppc64? ( mirror://gentoo/${P}-ppc64.tbz2 )"

LICENSE="as-is"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 sparc x86"
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

src_unpack() {
	base_src_unpack
	cd "${S}"

	# relocate from /usr to /opt/ghc
	sed -i -e "s|/usr|${LOC}|g" \
		usr/bin/ghc-${PV} usr/bin/ghci-${PV} usr/bin/ghc-pkg-${PV} \
		usr/bin/hsc2hs usr/$(get_libdir)/ghc-${PV}/package.conf

	sed -i -e "s|/usr/$(get_libdir)|${LOC}/$(get_libdir)|" \
		usr/bin/ghcprof

	# fix hardened gcc flags in the ghc driver script
	if grep -q GHC_CFLAGS usr/bin/ghc; then
		# Note! this will not be needed in the next version because the
		# ghc-bin .tbz2 files will have been generated from a version of
		# the ghc ebuild which inserted the right flags into the right files
		ewarn "QA: ghc driver script does not need fixing for this version!"
	else
		# We start by removing all the previous -optc-* flags.
		# Then we add $GHC_CFLAGS to the exec line. We replace a line that
		# never needed to be there in the first place (ie '#!/bin/bash') with
		# our line for setting GHC_CFLAGS= to the right set of flags.
		GHC_CFLAGS="-optc-nopie -optl-nopie -optc-fno-stack-protector"
		sed -i -e '$s|-optc[a-z-]*||g' \
			   -e 's|${TOPDIROPT}|${TOPDIROPT} ${GHC_CFLAGS}|' \
			   -e "s|#!/bin/bash|GHC_CFLAGS=\"${GHC_CFLAGS}\"|" \
			usr/bin/ghc-${PV}

		# For ghci we don't need these C flags at all
		sed -i -e '$s|-optc[a-z-]*||g' \
			   -e 's|#!/bin/bash||' \
			usr/bin/ghci-${PV}

		# We also change /bin/sh to /bin/bash in all the driver scripts since
		# we think /sbin/sh can't handle ${1+"$@"}. Again, this will be fixed
		# in the next rebuild of the ghc-bin .tbz2 files.
		sed -i -e "s|/bin/sh|/bin/bash|" \
			usr/bin/ghc-${PV} usr/bin/ghci-${PV} usr/bin/ghc-pkg-${PV}
	fi
}

src_compile() {
	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
	rmdir usr
}

src_install () {
	mv * "${D}"

	# remove this local copy of ghc-updater next time the .tbz2 files
	# are rebuilt, since then we'll pick up the fix from the ghc ebuild
	into /opt/ghc
	dosbin ${FILESDIR}/ghc-updater

	doenvd "${FILESDIR}/10ghc"
}

pkg_postinst () {
	ghc-reregister
	ewarn "IMPORTANT:"
	ewarn "If you have upgraded from another version of ghc-bin or"
	ewarn "if you have switched from ghc to ghc-bin, please run:"
	ewarn "	/opt/ghc/sbin/ghc-updater"
	ewarn "to re-merge all ghc-based Haskell libraries."
}

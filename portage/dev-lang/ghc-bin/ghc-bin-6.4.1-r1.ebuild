# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base multilib ghc-package

DESCRIPTION="Glasgow Haskell Compiler"
HOMEPAGE="http://www.haskell.org/ghc/"
# list all arches for proper digest building:
SRC_URI="ia64?  ( mirror://gentoo/${P}-ia64.tbz2 )"

LICENSE="as-is"
KEYWORDS="-* ~ia64"
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
}

src_compile() {
	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
	rmdir usr
}

src_install () {
	mv * "${D}"

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

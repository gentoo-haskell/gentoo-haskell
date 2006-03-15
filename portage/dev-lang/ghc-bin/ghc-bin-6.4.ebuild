# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="" # use the non-binary version if you want to have more choice

DESCRIPTION="Glasgow Haskell Compiler"
# list all arches for proper digest building:
SRC_URI="x86?  ( mirror://gentoo/${P}-r1-x86.tbz2 )
		 amd64? ( mirror://gentoo/${P}-r1-amd64.tbz2 )
		 sparc? ( mirror://gentoo/${P}-r1-sparc.tbz2 )
		 ppc? ( mirror://gentoo/${P}-r1-ppc.tbz2 )
		 ppc64? ( mirror://gentoo/${P}-r1-ppc64.tbz2 )"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="-alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

RESTRICT="nostrip" # already stripped

LOC="/opt/ghc"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1
	=sys-libs/readline-5*"

PROVIDE="virtual/ghc"

S="${WORKDIR}"

src_compile() {
	sed -i "s|/usr|${LOC}|g" usr/bin/* usr/lib/ghc-${PV}/package.conf
	mkdir -p ./${LOC}
	mv usr/* ./${LOC}
}

src_install () {
	cp -pr * ${D}
	insinto /etc/env.d
	doins ${FILESDIR}/10ghc
}

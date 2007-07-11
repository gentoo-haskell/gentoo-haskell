# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

DESCRIPTION="A fast, portable Haskell compiler and interpreter"
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/yhc/"
EDARCS_REPOSITORY="http://darcs.haskell.org/yhc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	dev-util/scons"
RDEPEND=""

EDARCS_GET_CMD="get --partial"

src_compile() {
	scons || die "compile failed"
}

src_install() {
	scons install prefix="${D}/usr" || die "install failed"
}

src_test() {
	scons test || die "test failed"
}

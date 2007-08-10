# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock bin"
inherit haskell-cabal darcs

DESCRIPTION="hspr - the HSP Runtime Environment"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/hsp/"
EDARCS_REPOSITORY="http://www.cs.chalmers.se/~d00nibro/hsp/"


LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/ghc dev-haskell/haskell-src-exts dev-haskell/harp dev-haskell/trhsx dev-haskell/hspr-sh-darcs"

S=${WORKDIR}"/hspr-darcs-0.2/hspr"

src_compile() {
	autoconf
	./configure \
		--prefix=/ \
		--sysconfdir=/etc \
		--exec-prefix=${D}/usr
	CABAL_CONFIGURE_FLAGS="--with-server-root=/var/hsp \
		--prefix=/ \
		--bindir=${D}/usr/bin \
		--libdir=${D}/usr/lib \
		--libexecdir=${D}/usr/libexec \
		--sysconfdir=/etc"
	haskell-cabal_src_compile
}

src_install() {
	haskell-cabal_src_install
	dodir /var/hsp
	dodir /etc/hspr
	dodir /etc/hspr/compiled
	touch ${D}/etc/hspr/.filemap
	dodir /etc/hspr/stubs
	insinto /etc/hspr/stubs
	doins stubs/*
}

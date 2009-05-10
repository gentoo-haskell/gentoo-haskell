# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A purely functional package manager"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://nix.cs.uu.nl"

MY_PV="${PV/_/}"

SRC_URI=" http://hydra.nixos.org/build/17407/download/1/${PN}-${MY_PV}.tar.bz2"
LICENSE="GPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# Haven't checked dependencies, but actually, there shouldn't
# be any except gcc ...
DEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	einfo $(ls)
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

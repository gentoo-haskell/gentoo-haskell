# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A purely functional package manager"
HOMEPAGE="http://nixos.org/nix"

#in case we have something like _pre15214
MY_PV="${PV/_/}"

SRC_URI="http://hydra.nixos.org/build/2860022/download/4/${PN}-${MY_PV}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="etc_profile"

COMMON_DEPENDS="
	app-arch/bzip2
	dev-db/sqlite
	dev-libs/openssl
	dev-lang/perl
	sys-libs/zlib
"
DEPEND="${COMMON_DEPENDS}
	virtual/perl-ExtUtils-ParseXS
"
RDEPEND="${COMMON_DEPENDS}
	dev-perl/DBD-SQLite
	dev-perl/DBI
	net-misc/curl
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	# TODO: emacs highlighter
	default
	if ! use etc_profile; then
		rm "${ED}"/etc/profile.d/nix.sh || die
	fi
}

pkg_postinstall() {
	if ! use etc_profile; then
		ewarn "${EROOT}etc/profile.d/nix.sh was removed (due to USE=-etc_profile)."
		ewarn "Please fix the ebuild by adding nix user/group handling."
	fi
}

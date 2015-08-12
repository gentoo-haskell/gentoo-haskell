# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="A purely functional package manager"
HOMEPAGE="http://nixos.org/nix"

#in case we have something like _pre15214
SRC_URI="http://nixos.org/releases/${PN}/${P}/${P}.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="etc_profile +gc doc"

COMMON_DEPENDS="
	app-arch/bzip2
	dev-db/sqlite
	dev-libs/openssl
	gc? ( dev-libs/boehm-gc )
	doc? ( dev-libs/libxml2
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	dev-lang/perl
	sys-libs/zlib
"
DEPEND="${COMMON_DEPENDS}
	>=sys-devel/bison-2.6
	>=sys-devel/flex-2.5.35
	virtual/perl-ExtUtils-ParseXS
"
RDEPEND="${COMMON_DEPENDS}
	dev-perl/DBD-SQLite
	dev-perl/WWW-Curl
	dev-perl/DBI
	net-misc/curl
"

src_configure() {
	econf $(use_enable gc)
}

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

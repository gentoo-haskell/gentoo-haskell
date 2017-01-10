# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit user

DESCRIPTION="A purely functional package manager"
HOMEPAGE="http://nixos.org/nix"

#in case we have something like _pre15214
SRC_URI="http://nixos.org/releases/${PN}/${P}/${P}.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+etc_profile +gc doc sodium"

RDEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	dev-db/sqlite
	dev-libs/openssl:0=
	net-misc/curl
	sys-libs/zlib
	gc? ( dev-libs/boehm-gc )
	doc? ( dev-libs/libxml2
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
	)
	sodium? ( dev-libs/libsodium )
	dev-lang/perl:=
	dev-perl/DBD-SQLite
	dev-perl/WWW-Curl
	dev-perl/DBI
"
DEPEND="${RDEPEND}
	>=sys-devel/bison-2.6
	>=sys-devel/flex-2.5.35
	virtual/perl-ExtUtils-ParseXS
"

pkg_setup() {
	enewgroup nixbld 30000
	for i in {1..10}; do
		# we list 'nixbld' twice to
		# both assign a primary group for user
		# and add an user to /etc/group
		enewuser nixbld${i} $((30000 +$i)) -1 /var/empty nixbld,nixbld
	done
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/nix/var \
		$(use_enable gc)
}

src_install() {
	# TODO: emacs highlighter
	default

	# TODO: will need a tweak for prefix
	keepdir             /nix/store
	fowners root:nixbld /nix/store
	fperms 1775         /nix/store

	doenvd "${FILESDIR}"/60nix-remote-daemon
	newinitd "${FILESDIR}"/nix-daemon.initd nix-daemon

	if ! use etc_profile; then
		rm "${ED}"/etc/profile.d/nix.sh || die
	fi
}

pkg_postinstall() {
	if ! use etc_profile; then
		ewarn "${EROOT}etc/profile.d/nix.sh was removed (due to USE=-etc_profile)."
	fi
}

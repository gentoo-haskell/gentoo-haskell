# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools libtool versionator

DESCRIPTION="Oracle Database Programming Interface for C (ODPI-C)"
HOMEPAGE="https://oracle.github.io/odpi/"
SRC_URI="https://github.com/oracle/odpi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/oracle-instantclient-basic-11"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Iinclude -fPIC" \
		LDFLAGS="${LDFLAGS} -shared -Wl,-soname=libodpic.so.$(get_major_version)" \
		LIBS="-ldl -lpthread"
}

src_install() {
	insinto /usr/$(get_libdir)
	newins lib/libodpic.so libodpic.so.${PV}
	dosym libodpic.so.${PV} /usr/$(get_libdir)/libodpic.so.$(get_major_version)
	dosym libodpic.so.${PV} /usr/$(get_libdir)/libodpic.so
	insinto /usr/include
	doins include/dpi.h
}

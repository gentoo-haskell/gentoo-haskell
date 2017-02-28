# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools libtool

DESCRIPTION="A C/C++ implementation of a Sass compiler"
HOMEPAGE="http://libsass.org"
SRC_URI="https://github.com/sass/libsass/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default

	eautoreconf
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Ott is a tool for writing definitions of programming languages and calculi. "
HOMEPAGE="http://www.cl.cam.ac.uk/~pes20/ott/"
SRC_URI="http://www.cl.cam.ac.uk/~pes20/ott/${PN}_distro_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_distro_${PV}"

src_compile() {
	emake world
}

src_install() {
	dobin bin/ott
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ott is a tool for writing definitions of programming languages and calculi. "
HOMEPAGE="http://www.cl.cam.ac.uk/~pes20/ott/"
SRC_URI="https://github.com/ott-lang/ott/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.9"
RDEPEND="${DEPEND}"

src_compile() {
	emake world
}

src_install() {
	dobin bin/ott
}

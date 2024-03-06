# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The 'elm' command line interface (binary)"
HOMEPAGE="http://elm-lang.org"
SRC_URI="https://github.com/elm/compiler/releases/download/${PV}/binary-for-linux-64-bit.gz -> ${P}.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="symlink"

RDEPEND=" symlink? ( !dev-lang/elm-compiler )"

QA_PREBUILD="/usr/bin/elm-bin"
QA_PRESTRIPPED="/usr/bin/elm-bin"

S=${WORKDIR}

src_prepare() {
	default
	mv ${P} elm-bin || die
}

src_install() {
	dobin elm-bin
	use symlink && dosym elm-bin /usr/bin/elm
}

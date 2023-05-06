# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Idris syntax highlighting and (eventually) other things for emacs"
HOMEPAGE="https://github.com/idris-hackers/idris-mode"
SRC_URI="https://github.com/idris-hackers/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
IUSE=""

KEYWORDS="~amd64"
SLOT="0"

DEPEND=""
RDEPEND="app-emacs/haskell-mode"

SITEFILE="50${PN}-gentoo.el"

RESTRICT=test # fails frequently

src_prepare() {
	default

	sed -e 's@"--ideslave"@"--nocolour" "--ideslave"@' \
		-i "${S}/inferior-idris.el" \
		|| die "Could not set --nocolour in inferior-idris.el"
}

src_test() {
	export HOME=${T}
	mkdir "${HOME}/.idris" || die

	default
}

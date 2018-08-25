# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta package for all Elm packages"
HOMEPAGE="https://github.com/elm-lang"

LICENSE="metapackage"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	~dev-lang/elm-compiler-${PV}
	~dev-lang/elm-make-${PV}
	~dev-lang/elm-package-${PV}
	~dev-lang/elm-reactor-${PV}
	~dev-lang/elm-repl-${PV}
"

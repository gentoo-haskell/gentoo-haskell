# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Light wrapper around errors from sqlite-simple."
HOMEPAGE="https://github.com/caneroj1/sqlite-simple-errors"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-haskell/text-1.2
	>=dev-haskell/parsec-3.1.9
	dev-haskell/sqlite-simple
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}"

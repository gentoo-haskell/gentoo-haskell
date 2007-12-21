# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

MY_PN="HPDF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PDF API for Haskell"
HOMEPAGE="http://www.alpheccar.org/en/posts/show/82"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
	>=dev-haskell/binary-0.3
	>=dev-haskell/encoding-0.1
	dev-haskell/mtl
	>=dev-haskell/zlib-0.3"

S="${WORKDIR}/${MY_P}"

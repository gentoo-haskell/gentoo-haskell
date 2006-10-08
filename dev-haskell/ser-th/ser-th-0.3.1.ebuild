# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="SerTH"
MY_P="${MY_PN}-${PV}"

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal

DESCRIPTION="A binary serialization library for Haskell"
HOMEPAGE="http://www.cs.helsinki.fi/u/ekarttun/SerTH/"
SRC_URI="http://www.cs.helsinki.fi/u/ekarttun/SerTH/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

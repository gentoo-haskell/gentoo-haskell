# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

MY_PN="Codec-Compression-LZF"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="LZF compression bindings."
HOMEPAGE="http://www.cs.helsinki.fi/u/ekarttun/Codec-Compression-LZF/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2"

S="${WORKDIR}/${MY_P}"

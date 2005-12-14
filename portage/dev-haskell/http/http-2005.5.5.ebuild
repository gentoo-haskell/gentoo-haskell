# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib haddock"
inherit base versionator eutils haskell-cabal

MY_PV_YEAR=$(get_version_component_range 1)
MY_PV_MONTH=$(get_version_component_range 2)
(( ${MY_PV_MONTH} < 10 )) && MY_PV_MONTH="0${MY_PV_MONTH}"
MY_PV_DAY=$(get_version_component_range 3)
(( ${MY_PV_DAY} < 10 )) && MY_PV_DAY="0${MY_PV_DAY}"
MY_PV="${MY_PV_YEAR}${MY_PV_MONTH}${MY_PV_DAY}"

DESCRIPTION="Haskell HTTP Package"
HOMEPAGE="http://www.haskell.org/http/"
SRC_URI="http://www.haskell.org/http/download/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="${PV}"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc
	dev-haskell/crypto"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	base_src_unpack
	epatch ${FILESDIR}/cabalfix.patch
}

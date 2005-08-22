# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock"
inherit base versionator haskell-cabal

MY_PV_YEAR=$(get_version_component_range 1)
MY_PV_MONTH=$(get_version_component_range 2)
(( ${MY_PV_MONTH} < 10 )) && MY_PV_MONTH="0${MY_PV_MONTH}"
MY_PV_DAY=$(get_version_component_range 3)
MY_PV="${MY_PV_YEAR}${MY_PV_MONTH}${MY_PV_DAY}"

DESCRIPTION="HaXR is a library for writing XML-RPC 
client and server applications in Haskell."
HOMEPAGE="http://www.haskell.org/haxr/"
SRC_URI="http://www.haskell.org/haxr/download/${PN}-${MY_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.4
		>=dev-haskell/haxml-1.13
		dev-haskell/http
		dev-haskell/crypto"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	base_src_unpack
	sed -i 's/Build-depends:/Build-Depends: network, /' ${S}/xmlrpc.cabal
}


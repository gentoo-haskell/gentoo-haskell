# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock"
inherit haskell-cabal

DESCRIPTION="HaXR is a library for writing XML-RPC 
client and server applications in Haskell."
HOMEPAGE="http://www.haskell.org/xmlrpc/"
SRC_URI="http://www.haskell.org/haxr/download/haxr-20050621.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.4
		dev-haskell/haxml
		dev-haskell/http
		dev-haskell/crypto"

S=${WORKDIR}/haxr-20050621

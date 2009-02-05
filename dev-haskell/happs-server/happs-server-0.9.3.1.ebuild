# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="HAppS-Server"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web related tools and services."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		>=dev-haskell/happs-data-0.9.2
		>=dev-haskell/happs-ixset-0.9.2
		>=dev-haskell/happs-state-0.9.2
		>=dev-haskell/happs-util-0.9.2
		=dev-haskell/haxml-1.13*
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/html
		dev-haskell/http
		dev-haskell/mtl
		dev-haskell/network
		<dev-haskell/parsec-3
		dev-haskell/xhtml"

S="${WORKDIR}/${MY_P}"

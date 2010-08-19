# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="mongoDB"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A driver for MongoDB"
HOMEPAGE="http://github.com/TonyGen/mongoDB"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary
		dev-haskell/bson
		dev-haskell/mtl
		dev-haskell/nano-md5
		dev-haskell/network
		dev-haskell/parsec
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.4"

S="${WORKDIR}/${MY_P}"

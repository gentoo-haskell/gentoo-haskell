# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="pureMD5"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MD5 implementations that should become part of a ByteString Crypto package."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/binary-0.4.0
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

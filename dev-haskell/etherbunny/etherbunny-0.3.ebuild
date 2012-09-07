# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

MY_PN="Etherbunny"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A network analysis toolkit for Haskell"
HOMEPAGE="http://etherbunny.anytini.com/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/network
		dev-haskell/pcap
		dev-haskell/binary"

S="${WORKDIR}/${MY_P}"

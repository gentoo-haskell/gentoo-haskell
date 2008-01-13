# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

MY_PN="Crypto"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Haskell Cryptographic Library"
HOMEPAGE="http://www.ben-kiki.org/oren/YamlReference"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	>=dev-haskell/hunit-1.0
	dev-haskell/quickcheck"

S="${WORKDIR}/${MY_P}"

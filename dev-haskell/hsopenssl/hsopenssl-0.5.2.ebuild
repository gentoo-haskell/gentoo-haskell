# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HsOpenSSL"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="(Part of) OpenSSL binding for Haskell"
HOMEPAGE="http://cielonegro.org/HsOpenSSL.html"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.6
		>=dev-haskell/network-2.1.0.0
		>=dev-haskell/time-1.1.1"

S="${WORKDIR}/${MY_P}"

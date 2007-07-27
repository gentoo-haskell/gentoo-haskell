# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Configuration file reading & writing"
HOMEPAGE="http://software.complete.org/configfile"
SRC_URI="http://software.complete.org/configfile/static/download_area/${PV}/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		dev-haskell/mtl
		>=dev-haskell/missingh-0.18.0"

S="${WORKDIR}/${PN}"

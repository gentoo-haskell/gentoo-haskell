# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="HSH"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library to mix shell scripting with Haskell programs"
HOMEPAGE="http://software.complete.org/hsh"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/hslogger
		>=dev-haskell/missingh-1.0.0
		dev-haskell/mtl
		dev-haskell/regex-base
		dev-haskell/regex-compat
		dev-haskell/regex-posix
		>=dev-lang/ghc-6.8.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"

S="${WORKDIR}/${MY_P}"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
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

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		dev-haskell/mtl
		dev-haskell/regex-compat
		>=dev-haskell/missingh-1.0.0
		dev-haskell/hslogger
		dev-haskell/filepath
		dev-haskell/regex-base
		dev-haskell/regex-posix"

S="${WORKDIR}/${MY_P}"

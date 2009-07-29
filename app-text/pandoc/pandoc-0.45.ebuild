# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib bin"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal versionator

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://sophos.berkeley.edu/macfarlane/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/xhtml
		dev-haskell/mtl
		dev-haskell/regex-compat
		dev-haskell/network
		dev-haskell/parsec
		!dev-haskell/pandoc"

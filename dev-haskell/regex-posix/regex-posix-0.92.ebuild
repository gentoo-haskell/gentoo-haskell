# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal eutils

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-haskell/cabal-1.2
		>=dev-lang/ghc-6.6
		>=dev-haskell/regex-base-0.80"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${PN}-0.92-splitbase.patch"
	epatch "${FILESDIR}/${PN}-0.92-newbytestring.patch"
}

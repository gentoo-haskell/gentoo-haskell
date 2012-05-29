# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin test-suite"
EGIT_REPO_URI="git://github.com/gentoo-haskell/hackport.git"
inherit git-2 haskell-cabal

DESCRIPTION="Hackage and Portage integration tool"
HOMEPAGE="https://github.com/gentoo-haskell/hackport"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		test? ( dev-haskell/extensible-exceptions
			dev-haskell/hunit
		)
		>=dev-haskell/cabal-1.10
		>=dev-haskell/http-4000.0.3
		dev-haskell/mtl
		dev-haskell/network
		dev-haskell/parsec
		dev-haskell/regex-compat
		dev-haskell/tar
		>dev-haskell/xml-1.3.5
		dev-haskell/zlib
		>=dev-lang/ghc-6.10.1"

src_prepare() {
	sed -e 's/^Version:.*/&.9999/' -i ${PN}.cabal || die # just to distinct from release install
}

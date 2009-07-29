# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib bin"
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
		dev-haskell/network"

src_unpack() {
	unpack "${A}"

	# the pandoc default is to build with -O0
	# we like optimizations though
	sed -i -e "s/-O0//" "${S}/pandoc.cabal"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, pretty, containers' \
		"${S}/pandoc.cabal"
	fi

}

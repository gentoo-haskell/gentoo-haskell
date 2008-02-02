# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="Scrap Your Boilerplate With Class"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/syb-with-class"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

src_unpack() {
	unpack ${A}

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, array' \
			-e '/Extensions:/a \
			KindSignatures, MultiParamTypeClasses' \
			"${S}/${PN}.cabal"
	fi
}

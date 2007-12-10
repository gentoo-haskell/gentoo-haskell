# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal versionator

DESCRIPTION="Versatile logging framework"
HOMEPAGE="http://software.complete.org/hslogger"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		dev-haskell/network
		dev-haskell/mtl"

src_unpack() {
	unpack "${A}"
	cabal-mksetup
	sed -i -e "s/mtl/mtl, unix/" \
		"${S}/hslogger.cabal"

	if version_is_at_least "1.2.0" "$(cabal-version)"; then
		sed -i -e '/Build-Depends:/a \
			, containers' \
			"${S}/hslogger.cabal"
		sed -i -e '1i{-# LANGUAGE PatternSignatures #-}' \
			"${S}/src/System/Log/Logger.hs"
	fi
}

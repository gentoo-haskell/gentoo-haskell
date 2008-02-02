# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib"
inherit haskell-cabal eutils

DESCRIPTION="Simplistic terminal library for Haskell"
HOMEPAGE="http://members.cox.net/stefanor/vty/dist/doc/html/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

src_unpack() {
	unpack "${A}"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
            , bytestring, containers' \
	"${S}/vty.cabal"
	fi
}

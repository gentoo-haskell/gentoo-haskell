# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"
inherit darcs haskell-cabal

DESCRIPTION="Hackage and Portage integration tool"
HOMEPAGE="http://www.haskell.org/~gentoo/gentoo-haskell/_darcs/current/projects/HackPort/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="<dev-haskell/cabal-1.1.7
	dev-haskell/filepath
	dev-haskell/http
	dev-haskell/mtl
	dev-haskell/network
	dev-haskell/tar
	dev-haskell/zlib"
RDEPEND="${DEPEND}"

EDARCS_GET_CMD="get --partial"
EDARCS_REPOSITORY="http://www.haskell.org/~gentoo/gentoo-haskell/"
S="${WORKDIR}/${P}/projects/HackPort/"

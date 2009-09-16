# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/haskell-updater/haskell-updater-0.9.1.0.ebuild,v 1.2 2009/09/16 06:56:21 kolmodin Exp $

CABAL_FEATURES="bin nocabaldep"
inherit haskell-cabal

DESCRIPTION="Rebuild Haskell dependencies in Gentoo"
HOMEPAGE="http://haskell.org/haskellwiki/Gentoo#haskell-updater"
SRC_URI="http://code.haskell.org/~kolmodin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86" # Add keywords as those archs have a binpkg
IUSE=""

DEPEND="=dev-lang/ghc-6.10*"

# Need a lower version for portage to get --keep-going
RDEPEND="|| ( >=sys-apps/portage-2.1.6
			  sys-apps/pkgcore
			  sys-apps/paludis )"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--bindir=/usr/sbin"

	cabal_src_compile
}

src_install() {
	cabal_src_install

	dodoc TODO
}

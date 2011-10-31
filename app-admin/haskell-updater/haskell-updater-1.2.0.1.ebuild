# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin nocabaldep"
inherit haskell-cabal

DESCRIPTION="Rebuild Haskell dependencies in Gentoo"
HOMEPAGE="http://haskell.org/haskellwiki/Gentoo#haskell-updater"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris" # Add keywords as those archs have a binpkg
IUSE=""

DEPEND=">=dev-lang/ghc-6.12.1"

# Need a lower version for portage to get --keep-going
RDEPEND="|| ( >=sys-apps/portage-2.1.6
			  sys-apps/pkgcore
			  sys-apps/paludis )"

src_prepare() {
	if use prefix; then
		sed -i -e "s,/var/db/pkg,${EPREFIX}&,g" \
		    "${S}/Distribution/Gentoo/Packages.hs" || die

		sed -i -e 's,"/","'"${EPREFIX}"'/",g' \
		    "${S}/Distribution/Gentoo/GHC.hs" || die
	fi
}

src_configure() {
	cabal_src_configure --bindir="${EPREFIX}/usr/sbin"
}

src_install() {
	cabal_src_install

	dodoc TODO
}

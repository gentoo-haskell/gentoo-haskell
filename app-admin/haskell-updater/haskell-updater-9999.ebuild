# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CABAL_FEATURES="bin nocabaldep"
inherit eutils haskell-cabal git-r3

DESCRIPTION="Rebuild Haskell dependencies in Gentoo"
HOMEPAGE="http://haskell.org/haskellwiki/Gentoo#haskell-updater"
#SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/gentoo-haskell/haskell-updater.git"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/ghc-6.12.1"

# Need a lower version for portage to get --keep-going
RDEPEND="|| ( >=sys-apps/portage-2.1.6
		sys-apps/pkgcore )"

src_prepare() {
	default

	if use prefix; then
		sed -i -e "s,/var/db/pkg,${EPREFIX}&,g" \
			"${S}/Distribution/Gentoo/Packages.hs" || die

		sed -i -e 's,"/","'"${EPREFIX}"'/",g' \
			"${S}/Distribution/Gentoo/GHC.hs" || die
	fi

	sed -e 's/^Version:.*/&.9999/' -i ${PN}.cabal || die # just to distinct from release install
}

src_configure() {
	cabal_src_configure \
		--bindir="${EPREFIX}/usr/sbin" \
		--constraint="Cabal == $(cabal-version)"
}

src_install() {
	cabal_src_install

	dodoc TODO
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

GTK_MAJ_VER="2"

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="Tools to build the Gtk2Hs suite of User Interface libraries."
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="${GTK_MAJ_VER}"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.8
		dev-haskell/happy
		dev-haskell/random
		>=dev-lang/ghc-6.10.1"

PATCHES=("${FILESDIR}"/${PN}-0.12.3-workaround-UName.patch
	"${FILESDIR}"/${PN}-0.12.3.1-ghc-7.5.patch
)

src_prepare() {
	base_src_prepare
	# c2hs ignores #if __GLASGOW_HASKELL__ >= 704
	if has_version ">=dev-lang/ghc-7.6.1"; then
		epatch "${FILESDIR}"/${PN}-0.12.3.1-remove-conditional-compilation-as-it-is-ignored-ghc-7.6.patch
	fi
	sed -e "s@Executable gtk2hsTypeGen@Executable gtk2hsTypeGen${GTK_MAJ_VER}@" \
		-e "s@Executable gtk2hsHookGenerator@Executable gtk2hsHookGenerator${GTK_MAJ_VER}@" \
		-e "s@Executable gtk2hsC2hs@Executable gtk2hsC2hs${GTK_MAJ_VER}@" \
		-i "${S}/${PN}.cabal" \
		|| die "Could not change ${PN}.cabal for GTK+ slot ${GTK_MAJ_VER}"
}

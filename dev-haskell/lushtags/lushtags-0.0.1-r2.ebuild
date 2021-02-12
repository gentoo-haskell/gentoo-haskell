# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.6.9999

CABAL_FEATURES="bin"
inherit vim-plugin haskell-cabal

DESCRIPTION="Create ctags compatible tags files for Haskell programs"
HOMEPAGE="https://github.com/bitc/lushtags"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	>=dev-haskell/haskell-src-exts-1.11
	>=dev-haskell/text-0.11
	>=dev-haskell/vector-0.9
	>=dev-lang/ghc-6.10.4
"

src_prepare() {
	cabal_chdeps \
		'vector == 0.9.*' 'vector >= 0.9' \
		'text == 0.11.*' 'text >= 0.11' \
		'haskell-src-exts == 1.11.*' 'haskell-src-exts >= 1.11'
}

src_install() {
	haskell-cabal_src_install

	# vim-plugin.eclass is insane
	dodir /usr/share/vim/vimfiles/plugin
	cp "${S}"/util/tagbar-haskell.vim "${ED}"/usr/share/vim/vimfiles/plugin/ || die
}

pkg_postinst() {
	haskell-cabal_pkg_postinst
	vim-plugin_pkg_postinst
}

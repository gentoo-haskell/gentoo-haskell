# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit haskell-cabal elisp-common

DESCRIPTION="Source code suggestions"
HOMEPAGE="http://community.haskell.org/~ndm/hlint/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		>=dev-haskell/cpphs-1.9
		=dev-haskell/haskell-src-exts-1.6*
		>=dev-haskell/hscolour-1.15
		dev-haskell/mtl
		=dev-haskell/uniplate-1.4*
        emacs? ( virtual/emacs
                 app-emacs/haskell-mode )"

RDEPEND="emacs? ( virtual/emacs
                  app-emacs/haskell-mode )"

SITEFILE="60${PN}-gentoo.el"

src_compile() {
	cabal_src_compile

	use emacs && elisp-compile data/hs-lint.el
}

src_install() {
	cabal_src_install

	if use emacs; then
		elisp-install ${PN} data/*.el data/*.elc || die "elisp-install failed."
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	dodoc hlint.htm
}

pkg_postinst() {
	ghc-package_pkt_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

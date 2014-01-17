# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin"
inherit elisp-common git-2 haskell-cabal

DESCRIPTION="Structured editing Emacs mode for Haskell"
HOMEPAGE="https://github.com/chrisdone/structured-haskell-mode"
EGIT_REPO_URI="https://github.com/chrisdone/structured-haskell-mode.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	>=dev-haskell/haskell-src-exts-1.14.0
	>=dev-lang/ghc-6.10.4
	emacs? ( virtual/emacs )
"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	haskell-cabal_src_compile
	if use emacs; then
		pushd elisp
		elisp-compile *.el || die
		popd
	fi
}

src_install() {
	haskell-cabal_src_install
	if use emacs; then
		elisp-install "${PN}" elisp/*.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	dodoc README.md
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}

pkg_postrm() {
	if use emacs; then
		elisp-site-regen
	fi
}

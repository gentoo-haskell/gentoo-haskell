# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit darcs haskell-cabal elisp

DESCRIPTION="Provides better support for editing Haskell by using GHC-Api. Currently only provides emacs support."
HOMEPAGE="http://shim.haskellco.de/"
EDARCS_REPOSITORY="http://shim.haskellco.de/shim/"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nostrip" # already stripped

RDEPEND=">=virtual/ghc-6.6
	virtual/emacs
	app-emacs/haskell-mode"

DEPEND="${RDEPEND}
	dev-haskell/cabal
	dev-haskell/network
	dev-haskell/filepath"

SITEFILE=70${PN}-gentoo.el

src_unpack() {
	darcs_src_unpack
}

src_compile() {
	cabal_src_compile

	elisp-compile *.el || die "elisp-compile failed!"
}

src_install() {
	cabal_src_install

	elisp-install ${PN} *.elc *.el || die "elisp-install failed!"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
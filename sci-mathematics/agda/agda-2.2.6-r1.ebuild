# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-2.2.6-r1.ebuild,v 1.1 2010/11/20 13:45:12 kolmodin Exp $

EAPI="2"

CABAL_FEATURES="lib"
inherit haskell-cabal eutils elisp-common

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A dependently typed programming language."
HOMEPAGE="http://appserv.cs.chalmers.se/users/ulfn/wiki/agda.php"
SRC_URI="http://code.haskell.org/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/emacs
	app-emacs/haskell-mode"
DEPEND="${RDEPEND}
	>=dev-lang/ghc-6.12
	dev-haskell/mtl
	=dev-haskell/quickcheck-2*
	dev-haskell/haskell-src
	dev-haskell/haskeline
	>=dev-haskell/binary-0.4.4
	=dev-haskell/xhtml-3000.2*
	>=dev-haskell/zlib-0.4
	>=dev-haskell/alex-2.0
	>=dev-haskell/happy-1.15"

SITEFILE="50${PN}2-gentoo.el"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-emacs.patch
}

src_install() {
	haskell-cabal_src_install
	elisp-install ${PN} src/data/emacs-mode/*.el \
		|| die "Failed to install emacs mode"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "Failed to install elisp site file"
}

pkg_postinst() {
	ghc-package_pkg_postinst
	elisp-site-regen
}

pkg_postrm() {
	ghc-package_pkg_prerm
	elisp-site-regen
}

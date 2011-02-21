# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda/agda-1.0.2-r2.ebuild,v 1.2 2010/09/14 19:53:51 bicatali Exp $

EAPI=2
inherit elisp-common eutils

MY_PN="Agda"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Proof assistant in Haskell"
HOMEPAGE="http://unit.aist.go.jp/cvs/Agda/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/emacs
	app-emacs/haskell-mode"
DEPEND="${RDEPEND}
	dev-lang/ghc
	dev-haskell/mtl"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-make_install.patch
	epatch "${FILESDIR}"/${P}-upstream-fixes.patch
	sed -e "s:-package lang::" -i src/Makefile.in \
		|| die "Failed to fix Makfile.in"
}

src_configure() {
	econf --enable-newsyntax
}

src_install() {
	emake -C src ROOT="${D}" install || die "emake install failed"
	dosym /usr/lib/EmacsAgda/bin/emacsagda /usr/bin/emacsagda
	dosym emacsagda /usr/bin/agda

	elisp-install ${PN} elisp/agda-mode.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}

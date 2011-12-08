# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib"
inherit haskell-cabal eutils elisp-common darcs

MY_PN="Agda"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A dependently typed functional programming language and proof assistant"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
EDARCS_REPOSITORY="http://code.haskell.org/Agda"
EDARCS_GET_CMD="get --verbose"
EDARCS_LOCALREPO="Agda2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="epic js"

RDEPEND=">=dev-haskell/binary-0.4.4
		epic? ( dev-haskell/epic )
		=dev-haskell/hashable-1.1*
		=dev-haskell/hashtables-1.0*
		=dev-haskell/haskeline-0.6*
		>=dev-haskell/haskell-src-exts-1.9.6
		=dev-haskell/mtl-2.0*
		=dev-haskell/quickcheck-2.4*
		<dev-haskell/syb-0.4
		=dev-haskell/xhtml-3000.2*
		<dev-haskell/zlib-1
		>=dev-lang/ghc-6.10.4"
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.8
		dev-haskell/happy"

SITEFILE="50${PN}2-gentoo.el"
S="${WORKDIR}/${P}"

src_prepare() {
	sed -e 's@epic >= 0.1.13 && < 0.2@epic >= 0.1.13 \&\& < 0.10@' \
		-i "${S}/${MY_PN}.cabal" || die "Could not loosen dependencies"
	epatch "${FILESDIR}"/${P}-emacs.patch
	cabal-mksetup
}

src_configure() {
	cabal_src_configure $(cabal_flag epic)
	cabal_src_configure $(cabal_flag js)
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

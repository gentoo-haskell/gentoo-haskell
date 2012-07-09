# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile"
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
KEYWORDS=""
IUSE="epic +stdlib"

RDEPEND=">=dev-haskell/binary-0.4.4[profile?]
		<dev-haskell/binary-0.6[profile?]
		epic? ( dev-lang/epic[profile?] )
		=dev-haskell/geniplate-0.6*[profile?]
		=dev-haskell/hashable-1.1*[profile?]
		=dev-haskell/hashtables-1.0*[profile?]
		>=dev-haskell/haskeline-0.6.3.2[profile?]
		<dev-haskell/haskeline-0.7[profile?]
		>=dev-haskell/haskell-src-exts-1.9.6[profile?]
		<dev-haskell/haskell-src-exts-1.14[profile?]
		>=dev-haskell/mtl-2.0[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/quickcheck-2.4[profile?]
		<dev-haskell/quickcheck-2.6[profile?]
		>=dev-haskell/syb-0.1[profile?]
		<dev-haskell/syb-0.4[profile?]
		=dev-haskell/unordered-containers-0.2*[profile?]
		=dev-haskell/xhtml-3000.2*[profile?]
		>=dev-haskell/zlib-0.4.0.1[profile?]
		<dev-haskell/zlib-0.6[profile?]
		>=dev-lang/ghc-6.10.4
		virtual/emacs
		app-emacs/haskell-mode"
PDEPEND="stdlib? ( sci-mathematics/agda-stdlib )"
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.8
		dev-haskell/happy"

SITEFILE="50${PN}2-gentoo.el"
S="${WORKDIR}/${P}"

src_prepare() {
	sed -e 's@QuickCheck >= 2.3 && < 2.5@QuickCheck >= 2.3 \&\& < 2.6@' \
		-i "${S}/${MY_PN}.cabal" || die "Could not loosen dependencies"
	sed -e '/.*emacs-mode.*$/d' \
		-e '/^executable agda/,$d' \
		-i "${S}/${MY_PN}.cabal" \
		|| die "Could not remove agda and agda-mode from ${MY_PN}.cabal"
	cabal-mksetup
}

src_configure() {
	cabal_src_configure $(cabal_flag epic)
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

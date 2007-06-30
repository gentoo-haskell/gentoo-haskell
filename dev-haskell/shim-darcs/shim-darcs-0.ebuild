# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit darcs haskell-cabal elisp-common

DESCRIPTION="Provides better support for editing Haskell in emacs and vim"
HOMEPAGE="http://shim.haskellco.de/"
EDARCS_REPOSITORY="http://shim.haskellco.de/shim/"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="emacs vim-syntax"

RESTRICT="nostrip" # already stripped

RDEPEND=">=virtual/ghc-6.6
	emacs? ( virtual/emacs
			 app-emacs/haskell-mode )
	vim-syntax? ( app-editors/vim )"

DEPEND="${RDEPEND}
	dev-haskell/cabal
	dev-haskell/network
	dev-haskell/filepath"

SITEFILE=70${PN}-gentoo.el

pkg_setup() {
	cabal_package_setup

	if use vim-syntax ; then
		ewarn "Vim support in shim is still experimental"
	fi
}

src_unpack() {
	darcs_src_unpack
}

src_compile() {
	cabal_src_compile

	if use emacs ; then
		elisp-compile *.el || die "elisp-compile failed!"
	fi
}

src_install() {
	cabal_src_install

	if use emacs ; then
		elisp-install ${PN} *.elc *.el || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/autoload
		doins vim/autoload/haskellcomplete.vim

		if [ -f /usr/share/vim/vimfiles/haskell.vim ] ; then
			cat vim/ftplugin/haskell.vim >> /usr/share/vim/vimfiles/ftplugin/haskell.vim
		else
			insinto /usr/share/vim/vimfiles/ftplugin
			doins vim/ftplugin/haskell.vim
		fi
	fi
}

pkg_postinst() {
	if use emacs ; then
		elisp-site-regen
	fi

	dodoc README HACKING docs

	elog "See /usr/share/doc/${PF}/README for more information"

	if use emacs ; then
		elog "Please see the following site for more information on"
		elog "how to use shim (the configuration is available via the"
		elog "site-gentoo.el file): "
		elog "    http://shim.haskellco.de/trac/wiki/ShimHowto"
	fi
}

pkg_postrm() {
	if use emacs ; then
		elisp-site-regen
	fi
}
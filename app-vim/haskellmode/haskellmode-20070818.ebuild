# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

VIM_PLUGIN_VIM_VERSION="7.0"

inherit eutils vim-plugin

DESCRIPTION="vim plugin: Provides IDE-like features for Haskell development"
HOMEPAGE="http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/"
SRC_URI="http://gentooexperimental.org/~shillelagh/${P}.zip"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND} app-arch/unzip"
RDEPEND=">=dev-lang/ghc-6.6
	net-misc/wget"

VIM_PLUGIN_HELPFILES="haskellmode"
VIM_PLUGIN_MESSAGES="filetype"

pkg_setup() {
	if ! built_with_use dev-lang/ghc doc ; then
		eerror "This plugin requires the Haddock documentation for GHC to be installed."
		die "Please re-emerge dev-lang/ghc with USE='doc'"
	fi
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	elog "You must set 'g:haddock_browser' to the path of your preferred browser, and"
	elog "depending on your setup you may also want to change the default value of"
	elog "'g:haddock_browser_callformat' (see ':help g:haddock_browser_callformat' for"
	elog "full usage info). You can persist these settings in your vimrc file, for"
	elog "example:"
	elog
	elog "    let g:haddock_browser=\"/usr/bin/elinks\""
	elog "    let g:haddock_browser_callformat=\"%s file://%s >/dev/null 2>&1 &\""
	elog
	elog "To enable GHC compiler integration, also add the following to your vimrc:"
	elog
	elog "    au BufEnter *.hs compiler ghc"
	elog
	elog "The first time you load haskellmode, you must generate a Haddock index. Do"
	elog "this with the command:"
	elog
	elog "    :ExportDocIndex"
	elog
	elog "Consult the help documentation for further setup information."
}

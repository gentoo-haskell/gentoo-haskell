# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

VIM_PLUGIN_VIM_VERSION="7.0"

inherit vim-plugin eutils

DESCRIPTION="vim plugin: Haskell mode"
HOMEPAGE="http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/"
SRC_URI="http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/vimfiles/compiler/GHC.vim
	http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/vimfiles/ftplugin/haskell.vim
	http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/vimfiles/ftplugin/haskell_doc.vim"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4"
RDEPEND="${DEPEND}"

VIM_PLUGIN_HELPURI="http://www.cs.kent.ac.uk/people/staff/cr3/toolbox/haskell/Vim/"
VIM_PLUGIN_MESSAGES="filetype"

pkg_setup() {
	if ! built_with_use dev-lang/ghc doc ; then
		eerror "Several of this plug-in's features require the Haddock-generated API"
		eerror "documentation for GHC to be installed."
		die "Please re-emerge dev-lang/ghc with USE='doc'"
	fi
}

src_unpack() {
	EPATCH_OPTS="-d ${DISTDIR}" epatch "${FILESDIR}/${P}-unixify.patch"
}

src_install() {
	insinto /usr/share/vim/vimfiles/compiler
	doins "${DISTDIR}/GHC.vim"
	insinto /usr/share/vim/vimfiles/ftplugin
	doins "${DISTDIR}/haskell.vim" "${DISTDIR}/haskell_doc.vim"
}

pkg_postinst() {
	elog "The :Doc and :IDoc commands open documentation in an external HTML browser."
	elog "To use this feature you must first set the Vim variable 'haddock_browser' to"
	elog "the path of your preferred browser. You can persist this setting via your"
	elog "vimrc file, for example:"
	elog
	elog "  let haddock_browser=\"/usr/bin/firefox\""
	elog
}

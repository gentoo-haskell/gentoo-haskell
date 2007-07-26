# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

VIM_PLUGIN_VIM_VERSION="7.0"

inherit vim-plugin

DESCRIPTION="vim plugin: Haskell indent mode"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1968"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=7407"

LICENSE="public-domain"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

VIM_PLUGIN_HELPTEXT="To load this plugin use the command:
\  :runtime indent/haskell.vim

You can modify the Vim variables 'haskell_indent_case' to change the
indentation for Haskell's 'case' keyword (default is 5 spaces) and
'haskell_indent_if' for the 'if' keyword (default is 3 spaces).

Example vimrc:
\  runtime indent/haskell.vim
\  let haskell_indent_case=4
\  let haskell_indent_if=2"

src_install() {
	insinto /usr/share/vim/vimfiles/indent
	# wget doesn't map the URI to filename correctly.
	newins "${DISTDIR}/download_script.php?src_id=7407" haskell.vim
}

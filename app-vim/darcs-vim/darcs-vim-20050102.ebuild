# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

VIM_PLUGIN_VIM_VERSION="6.4"

inherit vim-plugin

DESCRIPTION="vim plugin: Interactive interface to several darcs features from within Vim"
HOMEPAGE="http://robotics.eecs.berkeley.edu/~srinath/darcs/index.php"
SRC_URI="http://robotics.eecs.berkeley.edu/~srinath/darcs/darcs/darcs.vim"

LICENSE="vim"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

VIM_PLUGIN_HELPTEXT="The default key mappings for this plugin's functions are as follows:

\\\dkc
\  Start an interactive commit console.

\\\dki
\  Interactively choose between any two revisions of the current file and
\  display the diffsplit in the current window.

\\\dkv
\  Vertically diffsplit the current window against the last recorded version
\  of the file being edited."

src_install() {
	insinto /usr/share/vim/vimfiles/plugin
	doins "${DISTDIR}/darcs.vim"
}

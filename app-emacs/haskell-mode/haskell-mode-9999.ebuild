# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit elisp git-2

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://projects.haskell.org/haskellmode-emacs/
	http://www.haskell.org/haskellwiki/Haskell_mode_for_Emacs"
EGIT_REPO_URI="git://github.com/haskell/haskell-mode.git https://github.com/haskell/haskell-mode.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+examples"

RDEPEND="virtual/emacs
		dev-haskell/hasktags"
DEPEND="${RDEPEND}"

DOCS="NEWS README.md"
ELISP_TEXINFO="${PN}.texi"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# remove '@$(RM) $*.elc' and '@$(RM) haskell-mode.info' from 'make check'
	sed -e 's/\$(RM) \$\*\.elc/echo gento REFUSED to &/' \
		-e 's/check: clean/check:/' \
		-i Makefile || die
}

src_compile() {
	emake all
	if use examples; then
		pushd examples || die
		elisp-compile *.el || die
		popd
	fi
}

src_install() {
	elisp_src_install
	if use examples; then
		pushd examples || die
		elisp-install ${PN}/examples *.el *.elc || die
		dodir /usr/share/${PN}/examples
		insinto /usr/share/${PN}/examples
		doins *.hs
		popd
	fi
}

pkg_postinst() {
	elisp-site-regen

	elog "If you update from before version 2.5 you must reconfigure,"
	elog "or indentation will not work."
	elog "Read the README.md file in ${ROOT}usr/share/doc/${PF}."
	elog "or at: https://github.com/haskell/haskell-mode"
	elog "Add the following to ~/.emacs:"
	elog "(require 'haskell-mode-autoloads)"
	elog "There's a screen cast: http://www.youtube.com/watch?v=E6xIjl06Lr4"
	if use examples; then
		INIT_RAW="${ROOT}${SITELISP}/${PN}/examples/init.el"
		INIT_EX="${INIT_RAW/\/\///}"
		if [[ -f "${INIT_EX}" ]]; then
			elog "An example configuration is installed in"
			elog "${INIT_EX}"
		fi
	fi
}

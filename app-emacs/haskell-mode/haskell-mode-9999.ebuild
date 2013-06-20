# Copyright 1999-2012 Gentoo Foundation
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
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# remove '@$(RM) $*.elc' from 'make check'
	sed -e 's/\$(RM) \$\*\.elc/echo gento REFUSED to &/' \
		-i Makefile || die
}

src_compile() {
	elisp-make-autoload-file haskell-site-file.el || die
	elisp-compile *.el || die
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

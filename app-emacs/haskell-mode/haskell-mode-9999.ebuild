# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit elisp git-2

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://projects.haskell.org/haskellmode-emacs/
	http://www.haskell.org/haskellwiki/Haskell_mode_for_Emacs"
EGIT_REPO_URI="https://github.com/haskell/haskell-mode.git"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="+examples +snippets"

RDEPEND="virtual/emacs
		dev-haskell/hasktags"
DEPEND="${RDEPEND}"

DOCS="NEWS README.md"
ELISP_TEXINFO="${PN}.texi"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# remove '@$(RM) $*.elc' and '@$(RM) haskell-mode.info' from 'make check'
	sed -e 's/\$(RM) \$\*\.elc/echo gentoo REFUSED to &/' \
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
	if use snippets; then
		pushd snippets || die
		elisp-install ${PN}/snippets/${PN} ${PN}/* ${PN}/.* || die
		popd
	fi
}

pkg_postinst() {
	elisp-site-regen

	elog "Read the README.md file in ${ROOT}usr/share/doc/${PF}."
	elog "or at: https://github.com/haskell/haskell-mode"
	elog "The info haskell-mode documentation is included, or you can read it online:"
	elog "http://haskell.github.io/haskell-mode/manual/latest/"

	if use examples; then
		INIT_RAW="${ROOT}${SITELISP}/${PN}/examples/init.el"
		INIT_EX="${INIT_RAW/\/\///}"
		if [[ -f "${INIT_EX}" ]]; then
			elog "An example configuration is installed in"
			elog "${INIT_EX}"
		fi
	fi
}

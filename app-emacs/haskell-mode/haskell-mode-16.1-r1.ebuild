# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit elisp

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://projects.haskell.org/haskellmode-emacs/
	https://www.haskell.org/haskellwiki/Emacs#Haskell-mode"
SRC_URI="https://github.com/haskell/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.2+"
SLOT="0"
KEYWORDS="~amd64"

DOCS="NEWS README.md"
ELISP_TEXINFO="doc/${PN}.texi"
SITEFILE="50${PN}-gentoo.el"

RESTRICT=test # needs network access to elpa packages

src_prepare() {
	default

	# We install the logo in SITEETC, not in SITELISP
	# https://github.com/haskell/haskell-mode/issues/102
	sed -i -e "/defconst haskell-process-logo/{n;" \
		-e "s:(.*\"\\(.*\\)\".*):\"${SITEETC}/${PN}/\\1\":}" \
		haskell-process.el || die
}

src_compile() {
	# The autoloads aren't present in new releases and must be built.
	emake haskell-mode-autoloads.el
	elisp_src_compile
}

src_test() {
	# perform tests in a separate directory #504660
	mkdir test && cp -R *.el tests Makefile test || die
	emake -j1 -C test check
}

src_install() {
	elisp_src_install
	insinto "${SITEETC}/${PN}"
	doins logo.svg
}

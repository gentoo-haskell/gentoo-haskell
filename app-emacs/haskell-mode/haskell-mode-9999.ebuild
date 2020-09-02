# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit elisp git-r3

DESCRIPTION="Mode for editing (and running) Haskell programs in Emacs"
HOMEPAGE="http://projects.haskell.org/haskellmode-emacs/
	https://www.haskell.org/haskellwiki/Haskell_mode_for_Emacs"
EGIT_REPO_URI="https://github.com/haskell/haskell-mode.git"

LICENSE="GPL-3+ FDL-1.2+"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/emacs
		dev-haskell/hasktags"
DEPEND="${RDEPEND}"

DOCS="NEWS README.md"
ELISP_TEXINFO="doc/${PN}.texi"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	default
	# remove '@$(RM) $*.elc' and '@$(RM) haskell-mode.info' from 'make check'
	sed -e 's/\$(RM) \$\*\.elc/echo gentoo REFUSED to &/' \
		-e 's/check: clean/check:/' \
		-i Makefile || die
}

src_compile() {
	elisp_src_compile
	emake haskell-mode-autoloads.el
	elisp-compile haskell-mode-autoloads.el
}

src_test() {
	# perform tests in a separate directory #504660
	mkdir test && cp -R *.el tests Makefile test || die
	emake -C test check
}

src_install() {
	elisp_src_install
	insinto "${SITEETC}/${PN}"
	doins logo.svg
}

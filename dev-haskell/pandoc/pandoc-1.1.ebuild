# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal eutils

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="citeproc highlight html pdf"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/cabal-1.2
		>=dev-haskell/filepath-1.1
		>=dev-haskell/mtl-1.1
		>=dev-haskell/network-2
		>=dev-haskell/parsec-2.1
		<dev-haskell/parsec-3
		>=dev-haskell/utf8-string-0.3
		>=dev-haskell/xhtml-3000.0
		>=dev-haskell/zip-archive-0.1.1
        highlight? ( >=dev-haskell/highlighting-kate-0.2.3 )
        citeproc? ( dev-haskell/citeproc-hs )"

RDEPEND="${DEPEND}
         pdf? ( virtual/latex-base )
         html? ( app-text/htmltidy )"

pandoc_init() {
    pandoc="${PN}"
    pdfscript="markdown2pdf"
    htmlscript="html2markdown"
    markdownscript="hsmarkdown"
}

installMan() {
    local prog=$1
    doman "${S}/man/man1/${prog}.1"
}

src_unpack() {
    unpack ${A}

    # remove upper restriction on parsec
    sed -i -e 's/parsec >= 2.1 && < 3/parsec >= 2.1/' \
                "${S}/pandoc.cabal"

    # Patch Setup.hs to also build the html version of the README
    epatch "${FILESDIR}/${PN}-1.0.0.1-buildReadme.patch"

}

src_compile() {
    CABAL_CONFIGURE_FLAGS=""

    if use highlight; then
        CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=highlighting"
    else
        CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-highlighting"
    fi

    if use citeproc; then
        CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=citeproc"
    else
        CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-citeproc"
    fi

    cabal_src_compile
}

src_install() {
    pandoc_init
    cabal_src_install

    # pandoc itself is installed by cabal
    dobin "${markdownscript}"
    use pdf && dobin "${pdfscript}"
    use html && dobin "${htmlscript}"

    installMan "${pandoc}"
    installMan "${markdownscript}"
    use pdf && installMan "${pdfscript}"
    use html && installMan "${htmlscript}"

    # COPYING is installed by the Cabal eclass
    dodoc README  README.html COPYRIGHT changelog
}

pkg_postinst() {
    ghc-package_pkg_postinst

    elog "The script \"${markdownscript}\" is a drop-in replacement for"
    elog "the official markdown program"
}


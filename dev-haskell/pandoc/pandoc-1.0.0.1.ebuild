# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc html pdf"

DEPEND=">=dev-lang/ghc-6.8
		>=dev-haskell/cabal-1.2
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/filepath-1.1
		>=dev-haskell/mtl-1.1
		>=dev-haskell/network-2
		>=dev-haskell/parsec-2.1
		>=dev-haskell/utf8-string-0.3
		>=dev-haskell/xhtml-3000.0
		>=dev-haskell/zip-archive-0.1.1"

RDEPEND="${DEPEND}
		 pdf? ( virtual/latex-base
				dev-tex/latex-unicode )
		 html? ( app-text/htmltidy ) "

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
}

src_install() {
	pandoc_init
	cabal_src_install

	# pandoc itself is installed by cabal
	dobin "${markdownscript}"
	use pdf && dobin "${pdfscript}"
	use html && dobin "${htmlscript}"

	if use doc; then
		installMan "${pandoc}"
		installMan "${markdownscript}"
		use pdf && installMan "${pdfscript}"
		use html && installMan "${htmlscript}"
	fi

	# COPYING is installed by cabal
	dodoc README COPYRIGHT changelog
}

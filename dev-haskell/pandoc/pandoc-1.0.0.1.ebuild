# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
CABAL_MIN_VERSION="1.2"
inherit haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc html pdf"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/bytestring-0.9
		>=dev-haskell/filepath-1.1
		>=dev-haskell/mtl-1.1
		>=dev-haskell/network-2
		=dev-haskell/parsec-2.1*
		>=dev-haskell/utf8-string-0.3
		>=dev-haskell/xhtml-3000.0
		>=dev-haskell/zip-archive-0.1.1"

RDEPEND="${DEPEND}
		 pdf? ( virtual/latex-base
				dev-tex/latex-unicode )
		 html? ( app-text/htmltidy ) "



mdExt="md"
manExt="1"

MANPATH="${S}/man/man${manExt}/"

pandoc="${PN}"
pdfscript="markdown2pdf"
htmlscript="html2markdown"
markdownscript="hsmarkdown"

makeMan() {
	local prog=$1
	"${S}/${PN}" -s -o "${MANPATH}/${prog}.${manExt}" "${MANPATH}/${prog}.${manExt}.${mdExt}"
}

installMan() {
	local prog=$1
	doman "${MANPATH}/${prog}.${manExt}"
}

src_compile() {
	cabal_src_compile

	if use doc; then
		# pandoc's man pages are written in markdown, so we need to
		# parse them with pandoc first.
		makeMan "${pandoc}"
		makeMan "${markdownscript}"
		use pdf && makeMan "${pdfscript}"
		use html && makeMan "${htmlscript}"
	fi
}

src_install() {
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

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="citeproc highlight pdf test"

COMMONDEPS=">=dev-lang/ghc-6.8
		dev-haskell/extensible-exceptions
		>=dev-haskell/http-4000.0.5
		>=dev-haskell/mtl-1.1
		>=dev-haskell/network-2
		>=dev-haskell/parsec-2.1
		>=dev-haskell/utf8-string-0.3
		>=dev-haskell/xhtml-3000.0
		>=dev-haskell/zip-archive-0.1.1.4
		>=dev-haskell/xml-1.3.5
		dev-haskell/texmath
		highlight? ( >=dev-haskell/highlighting-kate-0.2.3 )
		citeproc? ( dev-haskell/citeproc-hs )"

DEPEND=">=dev-haskell/cabal-1.2
		${COMMONDEPS}"

RDEPEND="${COMMONDEPS}
		pdf? ( virtual/latex-base )"

pandoc_init() {
	pandoc="${PN}"
	pdfscript="markdown2pdf"
}

installMan() {
	local prog=$1
	doman "${S}/man/man1/${prog}.1"
}

src_unpack() {
	unpack ${A}

	# remove upper restriction on parsec
	sed -i -e 's/parsec >= 2.1 && < 3/parsec >= 2.1/' \
				"${S}/${PN}.cabal"
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

src_test() {
	./setup test || die "tests failed"
}

src_install() {
	pandoc_init
	cabal_src_install

	# pandoc itself is installed by cabal
	use pdf && dobin "${pdfscript}"

	installMan "${pandoc}"
	use pdf && installMan "${pdfscript}"

	# COPYING is installed by the Cabal eclass
	dodoc README  README.html COPYRIGHT changelog
}


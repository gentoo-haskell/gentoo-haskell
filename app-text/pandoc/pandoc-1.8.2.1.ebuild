# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Conversion between markup formats"
HOMEPAGE="http://johnmacfarlane.net/pandoc"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="highlight pdf test"

RDEPEND="=dev-haskell/base64-bytestring-0.1*
		>=dev-haskell/citeproc-hs-0.3.1
		=dev-haskell/dlist-0.5*
		<dev-haskell/http-4000.3
		>=dev-haskell/json-0.4
		<dev-haskell/mtl-2.1
		=dev-haskell/network-2.3*
		=dev-haskell/pandoc-types-1.8*
		>=dev-haskell/parsec-2.1
		=dev-haskell/tagsoup-0.12*
		=dev-haskell/texmath-0.5*
		=dev-haskell/utf8-string-0.3*
		=dev-haskell/xhtml-3000.2*
		>=dev-haskell/xml-1.3.5
		>=dev-haskell/zip-archive-0.1.1.7
		>=dev-lang/ghc-6.10.1
		highlight? ( <dev-haskell/highlighting-kate-0.4 )
		pdf? ( virtual/latex-base )"

DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		test? ( dev-haskell/ansi-terminal
			dev-haskell/diff
			dev-haskell/hunit
			dev-haskell/quickcheck:2
			dev-haskell/test-framework-hunit
			dev-haskell/test-framework-quickcheck2
			dev-haskell/test-framework
		)
		"

PATCHES=("${FILESDIR}/${PN}-1.8.2.1-tests-ghc-7.2.patch"
	"${FILESDIR}"/${PN}-1.8.2.1-ghc-7.4.patch)

pandoc_init() {
	pandoc="${PN}"
	pdfscript="markdown2pdf"
}

installMan() {
	local prog=$1
	doman "${S}/man/man1/${prog}.1"
}

src_prepare() {
	base_src_prepare
	sed -e 's@filepath >= 1.1 && < 1.3@filepath >= 1.1 \&\& < 1.4@g' \
		-e 's@json >= 0.4 && < 0.5@json >= 0.4 \&\& < 0.6@g' \
		-e 's@highlighting-kate >= 0.2.9 && < 0.3@highlighting-kate >= 0.2.9 \&\& < 0.4@g' \
		-e 's@old-time >= 1 && < 1.1@old-time >= 1 \&\& < 1.2@' \
		-e 's@HTTP >= 4000.0.5 && < 4000.2@HTTP >= 4000.0.5 \&\& < 4000.3@g' \
		-e 's@template-haskell >= 2.4 && < 2.7@template-haskell >= 2.4 \&\& < 2.8@g' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

src_configure() {
	cabal_src_configure \
		$(cabal_flag highlight highlighting) \
		$(cabal_flag test tests)
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

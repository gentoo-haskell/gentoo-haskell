# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils darcs autotools

DESCRIPTION="jhc is a haskell compiler"
HOMEPAGE="http://repetae.net/john/computer/jhc/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

EDARCS_REPOSITORY="http://repetae.net/repos/jhc"

DEPEND=">=dev-lang/ghc-6.10
	dev-haskell/binary
	>=dev-haskell/drift-2.1.1
	dev-haskell/fgl
	dev-haskell/happy
	dev-haskell/hssyck
	dev-haskell/mtl
	app-text/pandoc
	dev-haskell/readline
	dev-haskell/regex-compat
	dev-haskell/syb
	dev-haskell/utf8-string
	dev-haskell/zlib
	dev-perl/List-MoreUtils
	dev-perl/yaml
"
DEPEND="${DEPEND}	virtual/libiconv" # for source mangling
RDEPEND=""

src_prepare() {
	eautoreconf

	# (UTF-8 source breaks DrIFT. workaround DrIFT bug)
	cd "${S}/src/E/"
	mv TypeCheck.hs TypeCheck.hs.UTF-8
	iconv -f UTF-8 -t ASCII -c TypeCheck.hs.UTF-8 > TypeCheck.hs || die "unable to recode TypeCheck.hs to ASCII"
}

src_configure() {
	econf --with-hcflags="${HCFLAGS}"
}

src_compile() {
	emake jhc
	# jhc's makefile does not bother with library depends
	# so we don't as well. Thus: -j1
	emake -j1 libs
}

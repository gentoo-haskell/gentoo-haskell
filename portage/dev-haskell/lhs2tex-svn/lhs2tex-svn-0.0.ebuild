# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit subversion

ESVN_REPO_URI="https://svn.cs.uu.nl:12443/repos/lhs2TeX/trunk"

S="${WORKDIR}/lhs2TeX"

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.informatik.uni-bonn.de/~ralf/software.html#lhs2tex"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/ghc"

src_compile() {
	econf
	emake -j1 || die "emake failed"
}

src_install () {
	DESTDIR="${D}" make install || die "installation failed"
}


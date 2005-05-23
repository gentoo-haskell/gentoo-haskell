# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/Center/AttributeGrammarSystem"
# FIXME: make a snapshot of the following and stick it on the mirrors
SRC_URI="http://www.cs.uu.nl/wiki/pub/Center/AttributeGrammarSystem/${PN}.tar.gz"
LICENSE="Artistic"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~sparc"

IUSE=""

DEPEND=">=virtual/ghc-6.0"

S=${WORKDIR}/${PN}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	dobin ${S}/uuagc
}


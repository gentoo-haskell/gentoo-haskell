# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils base

DESCRIPTION="A text editor written in haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/yi.html"
SRC_URI="ftp://ftp.cse.unsw.edu.au/pub/users/dons/yi/snapshots/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc
	>=dev-haskell/hs-plugins-0.9.10
	dev-haskell/alex"

S=${WORKDIR}/yi

src_unpack() {
	base_src_unpack
	#apply a patch that is already upstream but not yet applied to a snapshot
	epatch ${FILESDIR}/buildsystem.patch
}

src_compile() {
	autoreconf
	econf
	emake
}

src_install() {
	make PREFIX=${D}/usr install
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils ghc-package

DESCRIPTION="A liberalised cpp-a-like preprocessor for Haskell"
HOMEPAGE="http://www.cs.york.ac.uk/fp/cpphs/"
SRC_URI="http://www.cs.york.ac.uk/fp/cpphs/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""
DEPEND=">=virtual/ghc-5.04"

src_compile() {
	$(ghc-getghc) --make -O cpphs.hs -o cpphs \
		|| die "ghc --make failed"
}

src_install() {
	dobin ${S}/cpphs
	dodoc README CHANGELOG
	doman docs/cpphs.1
	dohtml docs/index.html
}

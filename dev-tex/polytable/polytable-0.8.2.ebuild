# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/polytable/polytable-0.7.2.ebuild,v 1.7 2004/12/28 21:16:47 absinthe Exp $

inherit latex-package

DESCRIPTION="tabular-like environments with named columns"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/polytable/"
# originally from:
#SRC_URI="http://www.ctan.org/tex-archive/macros/latex/contrib/polytable/*"
# for portage use:
SRC_URI="mirror://gentoo/${P}.tar.gz"
# for testing:
SRC_URI="http://www.informatik.uni-bonn.de/~loeh/${P}.tar.gz"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""
DEPEND=">=dev-tex/lazylist-1.0a"
RDEPEND=""
S="${WORKDIR}/${PN}"

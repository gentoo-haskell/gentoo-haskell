# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-1.1.0.0.ebuild,v 1.1 2007/12/20 02:38:20 dcoutts Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2
inherit base haskell-cabal

MY_PN=QuickCheck
MY_P="${MY_PN}"
MY_FP="${MY_PN}-${PV/%_pre*/}"
# strip the _preX from the package version so we can find the correct file when
# fetching

DESCRIPTION="An automatic, specification based testing utility for Haskell programs"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://www.cs.chalmers.se/~ulfn/files/${MY_FP}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

S="${WORKDIR}/${MY_P}"

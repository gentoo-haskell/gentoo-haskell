# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Interface for versioning file stores."
HOMEPAGE=""
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/datetime
		dev-haskell/diff
		dev-haskell/filepath
		=dev-haskell/parsec-2*
		dev-haskell/regex-posix
		dev-haskell/split
		dev-haskell/time
		dev-haskell/utf8-string
		dev-haskell/xml"

RDEPEND="${DEPEND}
		|| ( dev-util/darcs dev-util/git )"

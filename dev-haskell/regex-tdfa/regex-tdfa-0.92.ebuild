# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile lib" # haddock docs do not build
inherit haskell-cabal

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/regex-base-0.80
		dev-haskell/mtl"

src_unpack() {
	unpack "${A}"

	# Fix building with mtl-1.0.1 (still works with 1.0)
	sed -i -e '/import Control.Monad.RWS/ a \
import Control.Monad \
import Data.Monoid' \
	"${S}/Text/Regex/TDFA/CorePattern.hs"

	sed -i -e '/import Control.Monad.RWS/ c \
import Control.Monad \
import Data.Monoid' \
	"${S}/Text/Regex/TDFA/TDFA.hs"
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="HaRP, or Haskell Regular Patterns is a Haskell regular expressions extension"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/harp/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/ghc"

S=${WORKDIR}/haskell-src-exts/src/harp

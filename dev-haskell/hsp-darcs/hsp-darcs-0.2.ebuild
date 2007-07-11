# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal
inherit darcs

DESCRIPTION="HSP - Haskell Server Pages (you might want hspr as well)"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/hsp/"
EDARCS_REPOSITORY="http://www.cs.chalmers.se/~d00nibro/hsp/"


LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/ghc dev-haskell/haskell-src-exts dev-haskell/harp dev-haskell/trhsx"

S=${WORKDIR}"/hsp-darcs-0.2/hsp"



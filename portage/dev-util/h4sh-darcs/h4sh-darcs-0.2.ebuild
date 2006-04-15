# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

DESCRIPTION="provides a set of Haskell List functions as normal unix shell
commands"
HOMEPAGE="http://www.cse.unsw.edu.au/~dons/h4sh.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

EDARCS_REPOSITORY="http://www.cse.unsw.edu.au/~dons/code/h4sh"
EDARCS_GET_CMD="get --partial --verbose"

DEPEND="sys-devel/make
    dev-lang/ghc
    dev-haskell/hs-plugins
    dev-haskell/cabal
    dev-haskell/fps"

# this functions checks weather the repository should be updated or downloaded
# from scratch
# $1 is repository $2 is directory from which to call darcs pull
download-darcs-repo() {
    EDARCS_REPOSITORY="$1" EDARCS_LOCALREPO="$2" darcs_fetch
}

src_unpack() {
    download-darcs-repo http://www.cse.unsw.edu.au/~dons/code/h4sh h4sh || die "h4sh download
    failure"
    darcs_src_unpack
}

src_compile() {
    PREFIX={$D} emake || die "could not make"

}

src_install() {
   make install || die "installation failed"
   dodoc AUTHORS HOWTO LICENSE DOC README

}

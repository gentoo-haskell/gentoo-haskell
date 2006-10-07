DESCRIPTION="A fast, portable Haskell compiler and interpretor"
HOMEPAGE="http://www-users.cs.york.ac.uk/~ndm/yhc"

EDARCS_REPOSITORY="http://darcs.haskell.org/yhc"

inherit darcs

SLOT="0"
KEYWORDS="x86 amd64"
LICENSE="GPL"

DEPEND="dev-lang/ghc-bin
        dev-util/scons"

src_compile() {
    scons
}

src_install() {
    scons install prefix=${D}/usr
}

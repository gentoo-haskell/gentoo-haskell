#!/usr/bin/env bash

ghcpath() {
    local p
    p=$(type -P ghc)
    if [[ -z $p ]]; then
        p="(not found)"
    fi
    echo "GHC Path: $p"
}

if [[ "$#" == "0" ||  "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: $0 <ghc-version>"
    echo
    echo "Welcome to the delicate task of bootstrapping ghc."
    echo "This script assumes that you have a working GHC version setup in"
    echo "your path to be used for the bootstrapping."
    echo
    echo "It is recommended that you install an older version of"
    echo "dev-lang/ghc, if it exists for your arch."
    echo
    echo "You may also need to set ACCEPT_KEYWORDS=\"~\${arch}\""

    ghcpath

    exit
fi

# we must be sure to build the binary package without using any flags
# that would make the binary require a specific cpu model.

# tuning for pentium4 is probably a reasonable choice for p4s and athlons
# sparc: CFLAGS="-mcpu=v9" to target 10+ year old hardware
export CFLAGS="-O2 -pipe"

# build with
#   - documentation
#   - bootstrapping
#   - disable ghci (ghcmakebinary)
export USE="-binary doc ghcbootstrap ghcmakebinary llvm ${USE}"

# disable docs compression in binpkg. Let user's make.conf decide:
# https://bugs.gentoo.org/667316
export PORTAGE_COMPRESS=true

ghcpath
echo "running:"
echo "  USE=\"${USE}\" CFLAGS=\"${CFLAGS}\" emerge --buildpkgonly =ghc-$1"

emerge --buildpkgonly =ghc-$1 || exit

echo "created $(portageq envvar PKGDIR)/dev-lang/ghc-$1.tbz2"
echo "to make the ghc-bin file just move it:"
echo "mv $(portageq envvar PKGDIR)/dev-lang/ghc-$1.tbz2 $(portageq envvar DISTDIR)/ghc-bin-$1-$(portageq envvar CHOST).tbz2"

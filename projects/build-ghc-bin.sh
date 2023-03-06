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

    exit 1
fi

GHC_VERSION="$1"
shift

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

# Use the new gpkg format, explicit xz compression with maximum compression
# format (xz seems to be better than zstd for binary files)
# Use as many threads as there are detected cores
export BINPKG_FORMAT="gpkg"
export BINPKG_COMPRESS="xz"
export BINPKG_COMPRESS_FLAGS_XZ="-9 --threads=0"

# This portage feature could affect the output filename
export FEATURES="$(portageq envvar FEATURES) -binpkg-multi-instance"

modified_envvars=(
    "CFLAGS=\"${CFLAGS}\""
    "USE=\"${USE}\""
    "PORTAGE_COMPRESS=\"${PORTAGE_COMPRESS}\""
    "BINPKG_FORMAT=\"${BINPKG_FORMAT}\""
    "BINPKG_COMPRESS=\"${BINPKG_COMPRESS}\""
    "BINPKG_COMRESS_FLAGS_XZ=\"${BINPKG_COMPRESS_FLAGS_XZ}\""
)

ghcpath
echo "running:"
printf "%s " "${modified_envvars[@]}"
echo "emerge --buildpkgonly ${@} =ghc-${GHC_VERSION}"

emerge --buildpkgonly "${@}" =ghc-${GHC_VERSION} || exit 1

echo "created $(portageq envvar PKGDIR)/dev-lang/ghc-${GHC_VERSION}.gpkg.tar"
echo "to make the ghc-bin file just move it:"
echo "cp -v $(portageq envvar PKGDIR)/dev-lang/ghc-${GHC_VERSION}.gpkg.tar $(portageq envvar DISTDIR)/ghc-bin-${GHC_VERSION}-$(portageq envvar CHOST).gpkg.tar"
echo "chmod a+r $(portageq envvar DISTDIR)/ghc-bin-${GHC_VERSION}-$(portageq envvar CHOST).gpkg.tar"

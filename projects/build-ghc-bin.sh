
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
    echo "Welcome to the delecate task of bootstrapping ghc."
    echo "This script assumes that you have a working GHC version setup in"
    echo "your path to be used for the bootstrapping."
    echo
    echo "It is recommended that you install an older version of"
    echo "dev-lang/ghc, if it exists for your arch."
    echo
    echo "You may also need to set PORTDIR_OVERLAY=\"\""
    echo "and also ACCEPT_KEYWORDS=\"~\${arch}\""

    ghcpath

    exit
fi

# we must be sure to build the binary package without using any flags
# that would make the binary require a specific cpu model.

# tuning for pentium4 is probably a reasonable choice for p4s and athlons
export CFLAGS="-O2 -pipe"

# build with the documentation and enable bootstrapping
export USE="-binary doc ghcbootstrap"

echo "You may also need to set PORTDIR_OVERLAY=\"\""
echo "and also ACCEPT_KEYWORDS=\"~\${arch}\""
ghcpath
echo "running:"
echo "  USE=\"${USE}\" CFLAGS=\"${CFLAGS}\" emerge --buildpkgonly =ghc-$1"

emerge --buildpkgonly =ghc-$1 || exit

echo "created /usr/portage/packages/dev-lang/ghc-$1.tbz2"
echo "to make the ghc-bin file just move it:"
echo "mv /usr/portage/packages/All/ghc-$1.tbz2 /usr/portage/distfiles/ghc-bin-$1.tbz2"

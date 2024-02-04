#!/bin/bash

# This script must be run in the GHC git directory
# git clone https://gitlab.haskell.org/ghc/ghc.git/

libraries=(
    array
    base
    binary
    bytestring
    deepseq
    directory
    exceptions
    filepath
    ghc-bignum
    ghc-compact
    ghc-prim
    hpc
    integer-gmp
    mtl
    pretty
    process
    stm
    terminfo
    time
    transformers
    unix
)

libraries_cabal_in=(
    ghc-boot
    ghc-boot-th
    ghc-heap
    ghci
    template-haskell
)

print_version() {
    echo -n "${1}: "
    sed -rne 's/^version:\s+(\S+)$/\1/pi' "$2"
}


if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <ghc version>"
    exit 1
fi

git checkout "ghc-${1}-release" >/dev/null || exit 1
git submodule foreach --recursive git reset --hard >/dev/null || exit 1
git submodule update --init --recursive >/dev/null || exit 1

cat \
    <(for l in "${libraries[@]}"; do print_version "$l" "libraries/${l}/${l}.cabal"; done) \
    <(for l in "${libraries_cabal_in[@]}"; do print_version "$l" "libraries/${l}/${l}.cabal.in"; done) \
    <(print_version Cabal "libraries/Cabal/Cabal/Cabal.cabal") \
    <(print_version containers "libraries/containers/containers/containers.cabal") \
    | sort

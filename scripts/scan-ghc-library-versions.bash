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
    ghc-boot
    ghc-boot-th
    ghc-compact
    ghc-heap
    ghc-prim
    ghci
    hpc
    integer-gmp
    mtl
    pretty
    process
    stm
    template-haskell
    terminfo
    time
    transformers
    unix
)

print_version() {
    local regexp='s/^version:\s+(\S+)$/\1/pi'
    local out="$(sed -rne "$regexp" "$2" 2>/dev/null)"
    if [[ -n "${out}" ]]; then
        echo -n "${1}: "
        echo "$out"
    fi
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
    <(for l in "${libraries[@]}"; do print_version "$l" "libraries/${l}/${l}.cabal.in"; done) \
    <(print_version Cabal "libraries/Cabal/Cabal/Cabal.cabal") \
    <(print_version containers "libraries/containers/containers/containers.cabal") \
    | sort

#!/usr/bin/env bash

# Find circular dependency across haskell packages
# in ::haskell overlay.

# Script's idea is very simple:
#
# 1. extract each package's dependency (pick latest available packages)
# 2. generate "package dependency" column of depends
# 3. run 'tsort' tool against the input to find loops
#
# It probably has some limitations in handling BDEPEND/DEPEND/RDEPEND
# and conditional USEs.
#
# TODO: script's way to tokenice DEPENDs is prute force via 'portageq'.
#       Ideally we should use portage's API directly to generate graph.
#       That should be a faster and more precise way to generate deps:
#       we could mark arcs explicitly (via-*DEPEND, via USE-flag, etc.).
#
# Example output and fixes: https://bugs.gentoo.org/760863#c9

export LANG=C

cd ../metadata/md5-cache

# Allow manual override of interesting packages
pkgs=("$@")
if [[ ${#@} -eq 0 ]]; then
    pkgs=(*/*)
fi

for p in "${pkgs[@]}"; do
    for dtype in BDEPEND DEPEND RDEPEND; do
        deps=($(
            # TODO: use EROOT instead of /
            #
            # We use 'mass_best_visible / ebuild' to avoid need to parse non-trivial
            # constraint syntax like '>=dev-lang/ghc-8.8.4[test?]':
            #
            # $ portageq mass_best_visible / ebuild '>=dev-lang/ghc-8.8.4[test?]'
            # >=dev-lang/ghc-8.8.4[test?]:dev-lang/ghc-8.8.4
            #
            # We dumt warnings as we don't handle 'foo? ( atoms.. )' correctly.
            # But resolution of 'atoms...' itself is good enough.
            portageq mass_best_visible / ebuild `egrep '^'${dtype}'=' -- "$p" | sed -e 's/^[^=]*=//'` 2>/dev/null |
            sed -e 's/.*://g' |
            # don't include ghc itself
            grep -v 'dev-lang/ghc-[[:digit:]]'
        ))
      # construct depends
      for d in "${deps[@]}"; do
          echo "${p} ${d}"
      done
    done
done | tsort

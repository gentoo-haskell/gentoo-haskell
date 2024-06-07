#!/bin/bash

# Run `emerge -DUu @world`, but exclude any Haskell packages. This is
# useful when you need to update your system but gentoo-haskell is
# creating a mess, or when you simply want to skip Haskell upgrades.
#
# Usage: scripts/world-update-no-haskell.bash [emerge opts...]


EMERGE=/usr/bin/emerge
HASKELL_UPDATER=(
	/usr/bin/haskell-updater
	--all
	--list
)

haskell_pkgs=(
    $("${HASKELL_UPDATER[@]}" | sort -u)
)

COMMAND=(
	$EMERGE -DUu --exclude dev-lang/ghc
)

for p in "${haskell_pkgs[@]}"; do
    COMMAND+=(--exclude "$p")
done

COMMAND+=("$@" @world)

printf "\"%s\" " "${COMMAND[@]}"; echo
"${COMMAND[@]}"

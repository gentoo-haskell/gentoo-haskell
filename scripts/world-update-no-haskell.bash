#!/bin/bash

# Run `emerge -DUu @world`, but exclude any Haskell packages. This is
# useful when you need to update your system but gentoo-haskell is
# creating a mess, or when you simply want to skip Haskell upgrades.
#
# Usage: scripts/world-update-no-haskell.bash [emerge opts...]


EMERGE=/usr/bin/emerge
EIX_UPDATE=/usr/bin/eix-update
EIX=(
	/usr/bin/eix
	--format '<installedversions:NAMESLOT>'
	--pure-packages
)
HASKELL_UPDATER=(
	/usr/bin/haskell-updater
	--all
	--list
)
HU_SED=(
	/usr/bin/sed -r 's/(.*):.$/\1/'
)

haskell_pkgs() {
    echo dev-lang/ghc
    "${HASKELL_UPDATER[@]}" | "${HU_SED[@]}"
}

not_haskell() {
	comm -2 -3 \
		<("${EIX[@]}" --world | sort -u) \
		<(haskell_pkgs | sort -u)
}

$EIX_UPDATE

COMMAND=(
	$EMERGE -1DUu "$@" $(not_haskell)
)

printf "\"%s\" " "${COMMAND[@]}"; echo
"${COMMAND[@]}"

#!/bin/bash

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Use this script like you would the `emerge` command, for instance:
# > projects/better-haskell-updater.bash -DUu --complete-graph @world
#
# This will pull in packages from the underlying emerge command and also all
# broken haskell packages. This should aid in rebuilding the necessary packages
# on the first try.

HASKELL_UPDATER="/usr/sbin/haskell-updater"
EMERGE="/usr/bin/emerge"
EIX="/usr/bin/eix"

for e in $HASKELL_UPDATER $EMERGE $EIX; do
    if [[ ! -x $e ]]; then
        echo "Could not find needed executable: $e"
        exit 1
    fi
done

$EMERGE --complete-graph --oneshot --ask \
    $($EMERGE --ignore-default-opts "$@" | $EIX --pipe --only-names) \
    $($HASKELL_UPDATER --list-only)

#!/bin/bash

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

eix="/usr/bin/eix"

# Get a random package from ::haskell that is not installed
random_pkg() {
	$eix --in-overlay haskell --and -\( -\! -I -\) -# | sort -R | head -1
}

while true; do
    pkg="$(random_pkg)"
    [ "$pkg" == "No matches found" ] && break
    emerge -1 -j1 --quiet-build --keep-going=y --deep --complete-graph "$pkg"
	haskell-updater -- -j1
done

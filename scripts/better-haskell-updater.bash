#!/bin/bash

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EIX=(
	/usr/bin/eix
	--installed-from-overlay haskell
	--format '<installedversions:NAMESLOT>'
	--pure-packages
)

XARGS=(
	/usr/bin/xargs
	-d'\n'
)

EMERGE=(
	/usr/bin/emerge
	--oneshot
	--complete-graph
	--keep-going
	--jobs=1
	--quiet-build
)

my_printf() {
	printf '"%s" ' "$@"
}

my_printf_other() {
	echo "$@ "
}

my_printf_finish() {
	echo
}

run_emerge() {
	local after_pipe=(
		"${XARGS[@]}"
		"${EMERGE[@]}"
		--update
		--deep
		"$@"
	)
	my_printf "${EIX[@]}"
	my_printf_other
	my_printf "${after_pipe[@]}"
	my_printf_finish

	"${EIX[@]}" | "${after_pipe[@]}"
}

run_haskell_updater() {
	local args=(
		haskell-updater
		--
		@preserved-rebuild
	)
	my_printf "${args[@]}"
	my_printf_finish

	"${args[@]}"
}

trap "exit 1" SIGINT

emerge_result=1
until [[ $emerge_result -eq 0 ]]
do

	run_emerge "$@"
	emerge_result=$?

	run_haskell_updater || exit 1
done

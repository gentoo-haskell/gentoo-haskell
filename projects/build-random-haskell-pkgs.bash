#!/bin/bash

# Copyright 1999-2022 Gentoo Authors
# Copyright 2022 hololeap
# Distributed under the terms of the GNU General Public License v2

# gentoo-haskell random install script
# v0.2.1
#
# Repeatedly tries to install a random package from ::haskell (that is not
# already installed and has at least one unmasked version)
#
# - Notes successes, errors, packages that try to downgrade, and packages that
#   fail to resolve
# - Rudimentary logger to files: /tmp/random-pkg-*
# - Runs `haskell-updater` after every attempt -- Aborts script if it fails
# - Aborts on on SIGINT (Ctrl+C)

EIX=(/usr/bin/eix)
EMERGE=(/usr/bin/emerge --ignore-default-opts --verbose --quiet-build --deep --complete-graph --oneshot)
HASKELL_UPDATER=(/usr/sbin/haskell-updater -- --ignore-default-opts --quiet-build)


declare -a completed=()
declare -a failed=()
declare -a tried_to_downgrade=()
declare -a resolve_failed=()
declare pkg=''
declare portage_output=''

log_portage_output() {
	local pkg="${1}"
	local portage_output="${2}"

	date
	echo "${pkg}"
	echo "${portage_output}"
	echo
}

finish() {
	echo
	echo "--------"
	echo
	echo "Results:"
	echo

	echo "Completed:"
	printf "%s\n" "${completed[@]}"
	echo

	echo "Failed:"
	printf "%s\n" "${failed[@]}"
	echo

	echo "These packages tried to downgrade:"
	printf "%s\n" "${tried_to_downgrade[@]}"
	echo

	echo "These packages failed to resolve:"
	printf "%s\n" "${resolve_failed[@]}"
	echo
}

error() {
	(
		echo
		if [[ "${pkg}" == "\n" ]]; then
			echo "Cancelling while trying ${pkg}"
		else
			echo "Cancelling"
		fi
	) >&2

	finish
	exit 1
}

# Get a random unmasked package from ::haskell that is not installed
random_pkg() {
        out="$("${EIX[@]}" --in-overlay haskell --and -\( -\! -I -\) --and --non-masked -#)"
	ret="$?"

	case "${ret}" in
		127)
			echo "Received exit code 127 from eix. Is it installed?" >&2
			return "${ret}"
			;;
		1)
			echo "${out}" >&2
			echo "No package matches found" >&2
			return "${ret}"
			;;
		0)
			;;
		*)
			echo "${out}" >&2
			echo "eix exited with unsuccessful code ${ret}" >&2
			return "${ret}"
			;;
	esac

	# Skip packages that have already been tried
	# Each of the arrays we check have timestamps at the front of each element
	# (hence `grep -q "${l}\$"`)
	readarray -t pkgs < <(echo "${out}" | while read -r l; do
		skip=0
		for c in "${completed[@]}"; do
			echo "$c" | grep -q "${l}\$" && skip=1
		done
		for f in "${failed[@]}"; do
			echo "$f" | grep -q "${l}\$" && skip=1
		done
		for d in "${tried_to_downgrade[@]}"; do
			echo "$d" | grep -q "${l}\$" && skip=1
		done
		for r in "${resolve_failed[@]}"; do
			echo "$r" | grep -q "${l}\$" && skip=1
		done
		[[ "${skip}" -eq 0 ]] && echo $l
	done)

	pool_size="${#pkgs[@]}"

	if [[ "${pool_size}" -eq 0 ]]; then
		echo "Pool is empty! Exiting..."
		return 1
	fi

	echo "Choosing from pool of ${#pkgs[@]} packages..." >&2
	for p in "${pkgs[@]}"; do echo $p; done | sort -R | head -1

	return "${ret}"
}


capture_portage_output() {
	cmd=("${EMERGE[@]}" --pretend --nospinner "${pkg}")
	echo "${cmd[@]}" >&2
	portage_output="$("${cmd[@]}" 2>&1)"

	local pretend_return=$?
	echo "pretend_return: \"${pretend_return}\"" >&2

	return "${pretend_return}"
}

check_for_downgrades() {
	if [[ -z "${portage_output}" ]]; then
		echo "No portage output!" >&2
		error
	fi

	if echo "${portage_output}" | grep '\[ebuild[^\[]*D[^\[]*\]' >&2; then
		echo "Downgrade detected: ${pkg}" >&2
		return 1
	else
		echo "No downgrade detected" >&2
		return 0
	fi
}

trap error SIGINT

while true; do
	( 
		echo
		echo --------
		echo
		echo "Looking for a random package from ::haskell that is not installed..."
	) >&2

        pkg="$(random_pkg)"
	[[ "$?" -eq 0 ]] || error
	echo "Trying ${pkg}" >&2

        if [[ "${pkg}" == "No matches found" ]]; then
		finish
		exit 0
	fi

	echo -n "Checking for downgrades... " >&2

	if capture_portage_output; then
		echo "${portage_output}" >&2
	else
		echo "${portage_output}" >&2
		log_file="/tmp/random-pkg-resolve-failed-${pkg//\//-}.log"
		
		echo "Failure while resolving with portage: ${pkg}" >&2
		echo "Saving output to ${log_file}" >&2

		log_portage_output "${pkg}" "${portage_output}" >> "${log_file}"

		resolve_failed+=( "$(date): ${pkg}" )

		continue
	fi
	
	if check_for_downgrades; then
	        if "${EMERGE[@]}" --keep-going=y "${pkg}"; then
			completed+=( "$(date): ${pkg}" )
		else
			failed+=( "$(date): ${pkg}" )
		fi

	        "${HASKELL_UPDATER[@]}" || error
	else
		log_file="/tmp/random-pkg-downgrade-${pkg//\//-}.log"
		echo "Saving output to ${log_file}" >&2

		log_portage_output "${pkg}" "${portage_output}" >> "${log_file}"

		tried_to_downgrade+=( "$(date): ${pkg}" )
	fi
done

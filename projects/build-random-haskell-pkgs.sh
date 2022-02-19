#!/bin/bash

# Copyright 1999-2022 Gentoo Authors
# Copyright 2022 hololeap
# Distributed under the terms of the GNU General Public License v2

# gentoo-haskell random install script
# v0.2.0
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
		if [[ -n "${pkg}" ]]; then
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
	if [[ "${ret}" -eq 127 ]]; then
		echo "Received exit code 127 from eix. Is it installed?"
		error
	fi
	echo "${out}" | sort -R | head -1 || true
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

		tried_to_downgrade+=( "${pkg}" )
	fi
done

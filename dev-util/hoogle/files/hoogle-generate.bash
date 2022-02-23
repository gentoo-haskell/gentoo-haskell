#!/bin/bash

HOOGLE=/usr/bin/hoogle
CMD=($HOOGLE generate "$@")

echo "Starting \"${CMD[@]}\""
output="$( "${CMD[@]}" )"
stat="$?"

if [ "${stat}" -eq 0 ]; then
    count="$( echo "${output}" | sed -rn -e 's/.*\[[0-9]+\/([0-9]+)\].*/\1/p' | tail -1 )"
    echo "hoogle generate successful. ${count} packages added to index"
else
    echo "${output}" | tail -3
    echo "${CMD[@]} failed with error code ${stat}"
fi

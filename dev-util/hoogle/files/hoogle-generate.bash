#!/bin/bash

HOOGLE=/usr/bin/hoogle
CMD=($HOOGLE generate "$@")

echo "Starting \"${CMD[@]}\""
output="$( "${CMD[@]}" )"
stat="$?"

if [ "${stat}" -eq 0 ]; then
    count="$( echo "${output}" | grep '[0-9]\+/[0-9]\+' | wc -l )"
    echo "hoogle generate successful. ${count} packages added to index"
else
    echo "${output}" | tail -3
    echo "${CMD[@]} failed with error code ${stat}"
fi

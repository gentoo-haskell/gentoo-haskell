#!/bin/sh
#
# Run dieharder set of tests for PRNG. All command line parameters are
# passed directly to the dieharder. If no parameters are given -a flag
# is passed which runs all available tests. Full list of dieharder
# options is available at dieharder manpage
#
# NOTE:
#   Full set of test require a lot of time to complete. From several
#   hours to a few days depending on CPU speed and thoroughness
#   settings.
#
# dieharder-source.hs is enthropy source for this test.
#
# This test require dieharder to be installed. It is available at:
#   http://www.phy.duke.edu/~rgb/General/dieharder.php

which dieharder > /dev/null || { echo "dieharder is not found. Aborting"; exit 1; }

ghc -fforce-recomp -O2 diehard-source
(
    date
    ./diehard-source | \
	if [ $# = 0 ]; then dieharder -a -g 200; else dieharder "$@" -g 200; fi
    date
) | tee diehard.log

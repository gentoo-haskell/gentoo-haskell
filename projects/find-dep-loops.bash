#!/usr/bin/env bash

# Find circular dependency across haskell packages
# in ::haskell overlay.

# Script's idea is very simple:
#
# 1. extract each package's dependency (pick latest available packages)
# 2. generate "package dependency" column of depends
# 3. run 'tsort' tool against the input to find loops
#
# Example output and fixes: https://bugs.gentoo.org/760863#c9

# Problems are printed on stderr
${PYTHON-python} dump_dep_graph.py | sort -u | LANG=C tsort >/dev/null

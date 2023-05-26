#!/usr/bin/env python

# takes the output from find-dep-loops.bash and formats it as a checklist that
# can be shared or posted to github or something

import sys

if not sys.stdin.isatty():
    # First, parse everything being piped into "chunks", each chunk representing
    # a dependency loop
    chunks = []
    chunk = []
    for line in sys.stdin:
        # don't need this from the tsort output
        line = line.lstrip("tsort:")
        # remove leading/trailing whitespace and newlines
        line = line.strip()
        # This will reduce verbosity
        line = line.replace("dev-haskell/", "")
        line = line.replace("*DEPEND=", "")

        if "input contains a loop" in line:
            if len(chunk) > 0:
                chunks.append(chunk)
                chunk = []
        else:
            if ":" in line:
                splitline = line.split(":")
                # only add the first half when the chunk is empty
                if len(chunk) == 0:
                    chunk.append(splitline[0])
                # always add the second part
                chunk.append(splitline[1])
            elif len(chunk) == 0:
                # Sometimes, the first line doesn't contain a ":"
                chunk.append(line)

    # get that last chunk
    if len(chunk) > 0:
        chunks.append(chunk)

    print("Note: unless a category is explicitly stated, then it is dev-haskell")
    print("Note: Any *DEPEND= type dependency has been stripped from the output")
    print()
    for chunk in chunks:
        prettyline = ' → '.join(chunk)
        print("- [ ] " + prettyline)
else:
    print("Currently this program only knows how to accept piped-in data")
    print("try: find-dep-loops.bash 2>&1 | python format_dep_loops.py")

#!/usr/bin/python

# tries to reorder the deps of a given list of packages so they
# are merged in order - liquidx@g.o (09 Oct 03)

import portage
import sys, string

fakedbapi = portage.fakedbapi()
varapi = portage.db["/"]["vartree"].dbapi

pkgs_to_reorder = sys.argv[1:]
pkgs_ordered = []

# key = catpkgver
# value = dependencies
dep_cache = {}

    
# very simply, we extract the dependencies for each package
for pkg in pkgs_to_reorder:
    try:
        deps, slot = varapi.aux_get(pkg, ["DEPEND", "SLOT"])
    except ValueError:
        sys.stderr.write("Error getting dependency information off " + pkg + "\n")
        continue
    try:
        realdeps = portage.dep_check(deps, fakedbapi)
    except TypeError:
        # we're probably running >=portage-2.0.50
        pkgsettings = portage.config(clone=portage.settings)        
        realdeps = portage.dep_check(deps, fakedbapi, pkgsettings)

    vardeps = []
    # match() finds the versions of all those that are installed
    for dep in realdeps[1]:
        vardeps = vardeps + varapi.match(dep)
    dep_cache[pkg] = vardeps

# topsort takes a graph (given as a dictionary with the nodes
# as keys and the outgoing edges as values), and returns a
# list of nodes that is topologically sorted
def topsort (graph) :
    visited = dict([(node,False) for node in graph.keys()])
    result = []

    def dfs_single (node) :
        visited[node] = True
        for adj in graph[node]:
            # we ignore dependencies that are not nodes in the graph
            if adj in graph.keys() and not visited[adj]:
                dfs_single (adj)
        result.append(node)

    for node in graph.keys():
        if not visited[node]:
            dfs_single (node)

    return result

pkgs_final_order = topsort(dep_cache)

print string.join(pkgs_final_order, "\n")
#print portage.dep_expand("=dev-python/sip-3.8", portage.portdb)
#print portage.dep_check("X? ( >=dev-python/sip-3.8 )", fakedbapi)

#!/usr/bin/env python

# Dump dependency graph to ease dependency loop search.

# TODO: instead of 'use_reduce' use:
#  - use `paren_reduce` and `dep_opconvert` to preserve USE values
#  - preserve flag names in package edges.
#  - preserve package's initial (or best) versions

import portage.dbapi.porttree

db = portage.dbapi.porttree.portdbapi()
haskell_repo = db.getRepositoryPath('haskell')

def print_edges(source, target):
    # hack: ignore any-of token as if list was 'all-of'
    if target == '||':
        return
    # hack: ignore dev-lang/ghc's depends. Assume it has no circular deps.
    if source == 'dev-lang/ghc':
        return

    # atom
    if isinstance(target, str):
        target_cp = portage.dep_getkey(target)
        print("%s %s" % (source, target_cp))
        return
    # atom list
    if isinstance(target, list):
        for t in target:
            print_edges(source, t)
        return
    raise ValueError("Uknown type %s (%r)" % (type(target), target))

# all packages:
for cp in db.cp_all(trees=[haskell_repo]):
    for cpv in db.cp_list(cp, mytree=haskell_repo):
        for dep in db.aux_get(cpv, mylist=['DEPEND', 'RDEPEND', 'BDEPEND'], mytree=haskell_repo):
            # "foo? ( a/a ) || ( b/b c/c )" -> ["a/a", "||", ["b/b", "c/c"]]
            dep_nouse = portage.dep.use_reduce(dep, matchall=True)
            # ["a/a", "||", ["b/b", "c/c"]] -> ["a/a", ["||", "b/b", "c/c"]]
            dep_nouse = portage.dep.dep_opconvert(dep_nouse)
            print_edges(cp, dep_nouse)

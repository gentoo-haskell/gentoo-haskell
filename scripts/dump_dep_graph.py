#!/usr/bin/env python

# Dump dependency graph to ease dependency loop search.

# TODO: instead of 'use_reduce' use:
#  - use `paren_reduce` and `dep_opconvert` to preserve USE values
#  - preserve flag names in package edges.
#  - preserve package's initial (or best) versions

import portage.dbapi.porttree

db = portage.dbapi.porttree.portdbapi()
haskell_repo = db.getRepositoryPath('haskell')

def print_edges(source, target, edge):
    # atom list
    if isinstance(target, list):
        if len(target) > 0 and isinstance(target[0], str) and target[0].endswith("?"):
            edge = target[0]
        for t in target:
            print_edges(source, t, edge)
        return

    # hack: ignore any-of token as if list was 'all-of'
    if target == '||':
        return

    # hack: avoid leading USE-conditional
    if target.endswith("?"):
        return

    # Ignore blockers like !a/b
    if portage.dep.Atom(target).blocker:
        return

    # hack: ignore dev-lang/ghc's depends. Assume it has no circular deps.
    if source == 'dev-lang/ghc':
        return

    # hack: These packages have warnings about their USE flags creating cycles
    #       and can be ignored
    if source == 'dev-haskell/attoparsec':
        return
    if source == 'dev-haskell/base-orphans':
        return
    if source == 'dev-haskell/clock':
        return
    if source == 'dev-haskell/colour':
        return
    if source == 'dev-haskell/foldable1-classes-compat':
        return
    if source == 'dev-haskell/hspec-core':
        return
    if source == 'dev-haskell/hspec-discover':
        return
    if source == 'dev-haskell/http-streams':
        return
    if source == 'dev-haskell/integer-logarithms':
        return
    if source == 'dev-haskell/nanospec':
        return
    if source == 'dev-haskell/network-uri':
        return
    if source == 'dev-haskell/parser-combinators':
        return
    if source == 'dev-haskell/primitive':
        return
    if source == 'dev-haskell/scientific':
        return
    if source == 'dev-haskell/splitmix':
        return
    if source == 'dev-haskell/tasty-expected-failure':
        return

    # atom
    if isinstance(target, str):
        target_cp = portage.dep_getkey(target)
        edge_name = source + ':' + edge + '=' + target_cp
        print("%s %s" % (source, edge_name))
        print("%s %s" % (edge_name, target_cp))
        return
    raise ValueError("Unknown type %s (%r)" % (type(target), target))

# Similar to 'portage.dep.dep_opconvert', but for USE predicates
def use_convert(deps):
    if isinstance(deps, str):
        return deps
    result = []
    i = 0
    while i < len(deps):
        if isinstance(deps[i], str) and deps[i].endswith("?"):
            # convert [..., "foo?", [ a/a ], ... ] to [..., ["foo?", "a/a"], ...]
            d = [deps[i]]
            d.append(use_convert(deps[i+1]))
            result.append(d)
            i += 2
        else:
            # Normal dep. Copy as is.
            result.append(use_convert(deps[i]))
            i += 1
    return result

# all packages:
for cp in db.cp_all(trees=[haskell_repo]):
    for cpv in db.cp_list(cp, mytree=haskell_repo):
        for dep in db.aux_get(cpv, mylist=['DEPEND', 'RDEPEND', 'BDEPEND'], mytree=haskell_repo):
            # "foo? ( a/a ) || ( b/b c/c )" -> ["foo?", [ "a/a" ], "||", ["b/b", "c/c"]]
            dep_tree = portage.dep.paren_reduce(dep)
            # [..., "||", ["b/b", "c/c"]] -> [ ..., ["||", "b/b", "c/c"]]
            dep_tree = portage.dep.dep_opconvert(dep_tree)
            # ["foo?", [ "a/a" ], ...] -> [ ["foo?", "a/a"], ...]
            dep_tree = use_convert(dep_tree)
            print_edges(cp, dep_tree, '*DEPEND')

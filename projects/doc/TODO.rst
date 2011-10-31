Perpetual TODO
==============

- [easy to hard] Add packages requested by people to the overlay.
  `HackPort <https://github.com/gentoo-haskell/hackport>`_ is a nice tool to do it fast.

- Improve `HackPort <https://github.com/gentoo-haskell/hackport>`_ tool.

- [easy] Some packages are patched on top of upstream. Ideally they shoud not :].
  Your goal is to push nice patches upstream. Haskell world is very eager
  in getting feedback, so it's a source of pleasure to work with upstream!

  Some code snippets on scanning the tree for such patched packages:

  - ``git grep PATCHES``
  - ``git grep epatch``
  - ``git grep git grep -E '\<sed\>'``

- [moderate] Some packages have their testuites, but ebuilds don't utilize it or
  have tests blocked. Blocked tests are easy to find with ``git grep RESTRICT``.

  Here is some notes to say:

  - upstream tests are sometimes unportable hacks, so your aim is to rework ill
    written testsuites by using ``Cabal`` recently introduced testing interface
    and/or using libraries helping in testing (``HUnit``, ``QuickCheck``,
    ``test-framework-*``). See tests in ``darcs`` as an advanced example.

- [moderate] Get ghc bugs fixed upstream, send patches

- [easy-to-moderate] Help fix & improve cabal. Improve cabal-install.

   * http://hackage.haskell.org/trac/hackage/report/9
   * http://darcs.haskell.org/cabal
   * http://darcs.haskell.org/cabal-install

- [easy] Write a program to check for build errors of package in overlay.

- [easy] run ``repoman full`` on the overlay and provide fixes for found
  QA notices.

Speculative TODO
================

- SLOT libs
- SLOT ghc (probly not possible with current portage)
- eclectic/haskell-config (related to SLOTting ghc & libs)

================================
Packages failing with GHC 6.12.3
================================

From the portage tree
=====================


dev-haskell/arrows
------------------

dev-haskell/hmake
------------------

dev-haskell/hsql
------------------

Needs to be bumped from hackage.

* dev-haskell/hsql-mysql
* dev-haskell/hsql-odbc
* dev-haskell/hsql-postgresql
* dev-haskell/hsql-sqlite

dev-haskell/hsshellscript-2.7.0
-------------------------------

Version 2.8.0 claims to work with ghc 6.10, but it seems to be already
broken with ghc 6.12.

dev-haskell/hxt
---------------

dev-haskell/lhs2tex-0.11
------------------------

Depends on cabal-1.1.6.2, needs to be bumped from the overlay.

dev-haskell/missingh
--------------------

New version from the overlay has more dependencies than the old version in
portage. Need testpack.

dev-haskell/wash
----------------

Probably hasn't worked in a long time.

dev-haskell/wxhaskell
---------------------

New cabal based versions are available in hackage. Partially put into the
overlay, but nothing finished, iirc.

So you say you wanna new ghc in tree? Great!

Quick-n-dirty start (aka. initial preparation):
==============================================

- go to ``dev-lang/ghc/``
- copy latest ebuild
- #comment-out all binary ``URIs`` from there (as we don't have them yet)
  - #comment-out all the options in ``yet_binary()``
- look at ``CABAL_CORE_LIB_GHC_PV`` variable in ebuilds and check
  what ones you need to update. I usually look at ``ghc/libraries/*/*.cabal``
  in ghc source tarball.
  - ``grep -l -r CABAL_CORE_LIB_GHC_PV= */*/*.ebuild | sort``
  - ``grep -i ^version: */*.cabal Cabal/*/*.cabal | sort``

Done! You can safely try to emerge your shiny new ghc!

Or not quite done (aka final cleanup):
======================================

If you really want to expose this ghc to users you'll need to add some
packages to the overlay. Those packages are **the only ones we allow to
update**. As of ghc-8.6.1, they are:

- binary
- Cabal
- ghc-api (virtual ebuild)
- haddock
- haddock-library
- haddock-api
- haskeline
- mtl
- parsec
- stm
- terminfo
- text
- transformers
- xhtml

(wisely) Use `hackport <https://raw.github.com/gentoo-haskell/hackport/master/README.rst>`_ for that!

Chances are high ghc will not be able to build quite a bit of packages. So mask
your shiny new ghc (and its libs) in ``profiles/package.mask`` like that:

::

    # Sergei Trofimovich <slyfox@gentoo.org> (21 Jul 2010)
    # The experimental branch. time is masked as haskell98 and random use them (ghc core)
    >=dev-lang/ghc-7.2
    >=dev-haskell/cabal-1.11
    >=dev-haskell/haddock-2.9.2.20110721

At least test if it's able to rebuild your whole environment with ``haskell-updater --upgrade``.
If things are fine you can unmask it.

Piece of cake!

Random notes
============

- haddock version is usually tied to ghc version
- if you use `ghc snapshots <http://www.haskell.org/ghc/dist/stable/dist>`_
  please copy them to some stable host before pushing to overlay.
  Snapshots on haskell.org are updated more, than once a day so tend to
  break checksums and go away.

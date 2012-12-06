So you say you wanna new ghc in tree? Great!

Quick-n-dirty start (aka. inital preparation):
==============================================

- go to ``dev-lang/ghc/``
- copy latest ebuild
- #comment-out all binary ``URIs`` from there (as we don't have them yet)
- look at ``CABAL_CORE_LIB_GHC_PV`` variable in ebuilds and check
  what ones you need to update. I usually look at ``ghc/libraries/*/*.cabal``
  in ghc source tarball.

  .. note::

      Updating ``CABAL_CORE_LIB_GHC_PV`` is an important step! Otherwise you
      might break your ghc installation if you forget to update some ebuild.
      Merging of such package will overwrite piece of installed package
      database bundled with ghc. When you unmerge such badly installed package
      it will unregister library, bundled with ghc and you'll likely break ghc.

      For more details about registration bits see ``ghc-register-pkg ()`` and
      ``ghc-reregister ()`` in ``eclass/ghc-package.eclass``.

Done. You can safely try to emerge your shiny new ghc!

Or not quite done (aka final cleanup):
======================================

If you really like to expose such ghc to users you'll need to add some
packages to overlay. Those packages are **the only ones we allow to update**. Now they are:

- haddock
- Cabal
- extensible-exceptions
- hpc

(wisely) Use `hackport <https://raw.github.com/gentoo-haskell/hackport/master/README.rst>`_ for that!

Chances are high ghc will not be able to build quite a bit of packages. So mask
your shiny new ghc (and it's libs) in ``profiles/package.mask`` like that:

::

    # Sergei Trofimovich <slyfox@gentoo.org> (21 Jul 2010)
    # The experimental branch. time is masked as haskell98 and random use them (ghc core)
    >=dev-lang/ghc-7.2
    >=dev-haskell/cabal-1.11
    >=dev-haskell/haddock-2.9.2.20110721

At least test it if it's able to to rebuild your whole environment with ``haskell-updater --upgrade``.
If things are fine you can unmask it.

Piece of cake!

Random notes
============

- haddock version is usually tied to ghc version
- if you use `ghc snapshots <http://www.haskell.org/ghc/dist/stable/dist>`_
  please copy them to some stable host before pushing to overlay.
  Snapshots on haskell.org are updated more, than once a day so tend to
  break checksums and go away.

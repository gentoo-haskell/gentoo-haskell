Suppose you want a new ghc be keyworded in ``::haskell`` overlay.

Let's pick today's example of ``ghc-8.4.3``. It has
``KEYWORDS=""`` because too many packages are not yet compatible
with it: upper bounds are too restrictive, build failures occur
due to incompatible changes in new ghc release and other breakages.

So when does ``KEYWORDS=""`` get populated back then?

Ideally every single package from ``::haskell`` overlay should
be buildable. But it's an unreachable ideal. Let's relax the rule:

Minimal requirement of keyworded GHC
====================================

1. All basic packages must be buildable on a popular ``ARCH`` (like ``amd64``)

   - dev-lang/ghc :)
   - dev-haskell/cabal-install
   - x11-wm/xmonad
   - dev-vcs/darcs
   - app-text/pandoc

   Feel free to add more here.

2. 75% of the ``::haskell`` overlay packages must be buildable.
   and pass their tests.

   ``75%`` looks like "a lot more more than a half". and should be
   good enough to be exposed to larger userbase of the overlay.

   Ideal goal is ``100%`` but it's unreachable most of the time as
   there is always a fraction of abandoned and unportable packages
   that will never be ported to newer GHC. Better mask such packages
   to schedule for eventual deletion.

   I usually run ``more_to_install.sh`` script from https://github.com/trofi/gentoo-qa/blob/master/more_to_install.sh
   to attempt to install most of packages:

   ::

       $ for p in $(/bound/gentoo-qa/more_to_install.sh); do echo $p; emerge -uv1 $p; done

   And then check how many of them succeeded:

   ::

       # How many are currently broken:
       $ /bound/gentoo-qa/more_to_install.sh | wc -l
       493
       # How many are installed successfully:
       ghc-pkg list --simple-output | wc -w
       1670

   Looks like we are at ``1670 / (493 + 1670) * 100 = 77%``! Geady to go!

3. ghc must have a gentoo prebuilt binary for a given architecture.

   I built binaries using ``projects/refresh-ghc-bin.bash`` from https://github.com/gentoo-haskell/gentoo-haskell/blob/master/projects/refresh-ghc-bin.bash.
   The script downloads latest stage3 and builds ghc against it.

   That way the resulting ghc binary should be suitable for default Gentoo install.

How to actually do it
=====================

Once the above requirements are met just restore ``KEYWORDS=`` for
architectures that have prebuilt binaries available and you are done!

Also make sure you restored ``KEYWORDS=`` for other packages that
depend on new ghc. Today's example:

- dev-haskell/transformers-0.5.5.0
- dev-haskell/terminfo-0.4.1.1
- dev-haskell/haddock-api-2.20.0
- dev-haskell/haddock-2.20.0

Those usually can be extracted by grepping commented out keywords:

::

    git grep -l '#keep in sync with ghc-8.4'

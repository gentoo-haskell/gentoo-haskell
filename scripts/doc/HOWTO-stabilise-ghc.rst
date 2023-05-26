Suppose you want a new ghc be stabilised in ::gentoo.

I'll pick ``dev-lang/ghc-7.8.4`` as an example.

Arches to stabilise
===================

We try to stabilise all arches at once as it makes
fixing packages easier: you mostly need to target
two ghc versions to support in each haskell package:
one stable and one unstable.

Our standard list of arches:

    alpha amd64 ia64 ppc ppc64 sparc x86

Packages to stabilise
=====================

First off you'll need to grab a list of packages to stabilise.
It's at least all the packages that come bundled with ghc
and have corresponding ebuilds and list of old stable packages
that will fail to build after major ghc upgrade.

To gather bundled bits I usually unpack source tarball and look
at ``utils/`` and ``libraries/``. But be careful: sometimes
we bump things in ghc's ``src_prepare()`` phase. See ``BUMP_LIBRARIES`` array
for overrides.

This time they are:

libraries
---------

- Cabal-1.18.1.5
- binary-0.7.1.0
- deepseq-1.3.0.2 (masked for removal currently)
- haskeline-0.7.1.2
- hoopl-3.10.0.1 (overlay only)
- hpc-0.6.0.2
- old-locale-1.0.0.7 (already stable)
- old-time-1.1.0.3 (already stable)
- terminfo-0.4.0.0
- transformers-0.3.0.0 (already stable)
- xhtml-3000.2.1 (already stable)

utils
-----

- haddock-2.14.3(.0.7.8.4) (version is in slight mismatch as we packaged tarball in gentoo)

old broken stable packages
--------------------------

This is the hard part. It requires building a few packages :)

Suppose we are stabilising for ``amd64``. Let's grep all the known stable
packages there:

::

    $ portageq --maintainer-email haskell@gentoo.org --no-version > stable-to-check-against-ghc-7.8

And now try to build them. Whatever does not build requires stabilising new version:

::

  $ emerge -1 -j$(nproc) $(cat stable-to-check-against-ghc-7.8)

Simple :)

Previous stabilisations
-----------------------

- `ghc-7.8.4 <https://bugs.gentoo.org/show_bug.cgi?id=524790#c23>`_
- `ghc-7.10.3 <https://bugs.gentoo.org/show_bug.cgi?id=563090#c4>`_

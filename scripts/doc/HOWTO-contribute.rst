Wiki
====

More info can be found in `the wiki <https://github.com/gentoo-haskell/gentoo-haskell/wiki/General-QA-tips>`_.

Quick start
===========

So, you need to grab our overlay, add some patches there and send them to us.

It's mostly a set of following commands:

::

   # first-time preparation
   $ git clone https://github.com/YOU-AT-GITHUB/gentoo-haskell.git
   $ git remote add upstream https://github.com/gentoo-haskell/gentoo-haskell.git
   $ git remote update
   #
   # usual workflow:
   #   update:
   $ git pull --rebase upstream master
   #   hax-in the patch:
   $ git commit -m "meaningful message"
   #   push:
   $ git push -f origin master
   #   go to your github page to send pull request

Some notes:

- ``--rebase`` parameter allows us to avoid useless merge commits:
  commits are usually absolutely independent, so we like linear history.

- Commit one ebuild at a time: don't modify more than one package
  in single commit. It makes reviewing easier.

- Strongly consider using ``pkgdev commit`` instead of ``git commit``
  (you will need to emerge pkgdev to do this). This enforces a minimum level
  of quality assurance required to merge your commit, and can catch out a lot
  of simple mistakes.

- Write meaningful commit messages! Look at the examples in the tree:
  ``git log``

  ::

      app-admin/haskell-updater: bump up to 1.2.0.1 (ghc-7.2 support)

If you don't like github for some reason, you can send us patches as well.
Just export them (or publish the tree somewhere else) and send them out
to haskell@gentoo.org:

::

    $ git format-patch -o PATCHES upstream/master..
    $ git send-email --to=haskell@gentoo.org PATCHES/

Simple!

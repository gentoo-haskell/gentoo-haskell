Quick start
===========

So, you need to grab our overlay, add some patches there and send it us.

It's mostly a set of following commands:

::

   # first-time preparation
   $ git clone git://github.com/YOU-AT-GITHUB/gentoo-haskell.git
   $ git remote add upstream git://github.com/gentoo-haskell/gentoo-haskell.git
   $ git remote update
   #
   # usual workflow:
   #   update:
   $ git pull --rebase upstream master
   #   hax-in teh patch:
   $ git commit -m "meaningful message"
   #   push:
   $ git push -f origin master
   #   go to your github page to send pull request

Some notes:

- ``--rebase`` parameter allows us to avoid useless merge commits:
  commits are usually absolutely independent, so we like linear history.

- Commit one ebuild at a time: don't modify more, than one package
  in single commit. It makes review easier.

- Write meaningful commit messages! Look at the examples in the tree:
  ``git log``

  ::

      app-admin/haskell-updater: bump up to 1.2.0.1 (ghc-7.2 support)

If you don't like github for some reason you can send us patches as well.
Just export them (or publish the tree somewhere else) and send them out
to haskell@gentoo.org:

::

    $ git format-patch -o PATCHES upstream/master..
    $ git send-email --to=haskell@gentoo.org PATCHES/

Simple!

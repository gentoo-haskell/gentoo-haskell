Gentoo Haskell project
**********************

travis.ci:

.. image:: https://travis-ci.org/gentoo-haskell/gentoo-haskell.svg?branch=master
    :target: https://travis-ci.org/gentoo-haskell/gentoo-haskell

Quickest start
==============

Haskell overlay consists of unstable software, so you'll
likely need to keyword everything in it::

    # install layman, if you don't have it yet:
    emerge layman
    layman -f
    echo source /var/lib/layman/make.conf >> /etc/portage/make.conf
    #
    # and the overlay configuration itself:
    layman -a haskell
    # and unmask unstable versions for your arch:
    echo "*/*::haskell ~$(portageq envvar ARCH)" >> /etc/portage/package.accept_keywords

And here is the trick to speed up metadata resolution a bit.
If you happen to use ``eix-sync`` for rsyncs you might
like the following ``/etc/eix-sync.conf``::

    *
    @egencache --jobs="$(($(nproc) + 1))" --repo=haskell --update --update-use-local-desc

It basically means:

- sync overlays in layman list before the main tree sync

- generate metadata for haskell repo after main
  tree sync is done, using N+1 cores

Developer's corner
==================

Have a nice haskell-related ebuild to share with community?
Look at our `Developer's README`_!

.. _Developer's README: http://github.com/gentoo-haskell/gentoo-haskell/blob/master/projects/doc/README.rst

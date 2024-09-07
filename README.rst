Gentoo Haskell project
**********************

|pkgcheck-badge|

.. |pkgcheck-badge| image:: https://github.com/gentoo-haskell/gentoo-haskell/workflows/pkgcheck/badge.svg
    :target: https://github.com/gentoo-haskell/gentoo-haskell/actions?query=workflow%3Apkgcheck

IRC
===

Find us in ``#gentoo-haskell`` on `libera.chat`_!

.. _libera.chat: https://libera.chat

Quickest start
==============

First, let's enable the Gentoo Haskell overlay using the eselect-repository method::

    # Install eselect-repository if you don't already have it
    emerge app-eselect/eselect-repository
    # Fetch and output the list of overlays
    eselect repository list
    eselect repository enable haskell

Finally, we need to unmask the overlay (this does not apply if your system
is already running on the ~testing branch)::
    # Unmask ~testing versions for your arch:
    echo "*/*::haskell" >> /etc/portage/package.accept_keywords

And here is the trick to speed up metadata resolution a bit.
If you happen to use ``eix-sync`` for rsyncs you might
like the following ``/etc/eix-sync.conf``::

    *
    @egencache --jobs="$(($(nproc) + 1))" --repo=haskell --update --update-use-local-desc

It basically means:

- sync overlays in layman list before the main tree sync

- generate metadata for haskell repo after main
  tree sync is done, using N+1 cores

Overlay Priority
================

Gentoo has a mechanism to define which ebuild is selected in the event
a package has the same version number in two different
repositories. This is detailed in the Gentoo wiki:
https://wiki.gentoo.org/wiki//etc/portage/repos.conf
The ebuild in the repository with the highest priority will be selected.

When using the haskell overlay, ebuilds in this overlay should take
precedence over the ebuilds in the main Gentoo repository, so you need
to set the priorities accordingly.

Check the current priority in ``/etc/portage/repos.conf/gentoo.conf``::

  priority = -1000

Note: -1000 is the default value, but you may have changed it previously

In the haskell section of
``/etc/portage/repos.conf/layman.conf`` confirm the priority ::

  [haskell]
  priority = 50
  location = /var/lib/layman/haskell
  layman-type = git
  sync-type = laymansync
  sync-uri = https://github.com/gentoo-haskell/gentoo-haskell.git
  auto-sync = Yes

The value in the haskell section needs to be higher than in the
``gentoo.conf`` file - if it isn't, then modify one or both so it is.

Developer's corner
==================

Have a nice haskell-related ebuild to share with community?
Look at our `Developer's README`_!

.. _Developer's README: http://github.com/gentoo-haskell/gentoo-haskell/blob/master/scripts/doc/README.rst

Loner's corner
==============

Alternatively if you really don't want to share any ebuilds (want to keep
outdated package versions, highly experimental things, publicly unavailable
stuff, other reasons) that's also fine.

You can keep such ebuilds in your local overlay.

Here is a complete example of creating minimal overlay with a
single haskell ebuild from hackage::

    # create overlay and populate it (gentoo-generic):
    $ mkdir my-ovl
    $ cd    my-ovl
    $ mkdir metadata
    $ echo 'masters = gentoo' > metadata/layout.conf
    # register an overlay in /etc/portage/repos.conf:
    $ echo '[my-ovl]' >> /etc/portage/repos.conf
    $ echo "location = $(pwd)" >> /etc/portage/repos.conf
    
    # haskell-specific stuff
    $ hackport -p . update
    # DONE!
    
    # adding an example ebuild
    $ hackport merge hichi
    $ emerge -av1 hichi

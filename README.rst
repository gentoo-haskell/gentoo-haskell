Gentoo Haskell project
**********************

|pkgcheck-badge|

.. |pkgcheck-badge| image:: https://github.com/gentoo-haskell/gentoo-haskell/workflows/pkgcheck/badge.svg
    :target: https://github.com/gentoo-haskell/gentoo-haskell/actions?query=workflow%3Apkgcheck

IRC
===

Find us in ``#gentoo-haskell`` on `libera.chat`_!

.. _libera.chat: https://libera.chat


----

Quick start
===========

Enable the ``haskell`` repository in the normal manner explained here::

https://wiki.gentoo.org/wiki/Eselect/Repository

Optionally, enable a sync hook to automatically generate metadata for you::

https://wiki.gentoo.org/wiki//etc/portage/repo.postsync.d#Pkgcore_example


Overlay Priority
----------------

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

----

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

You can keep such ebuilds in a local repository. See "`Creating an ebuild
repository`_" for instructions on how to set one up.

.. _Creating an ebuild repository: https://wiki.gentoo.org/wiki/Creating_an_ebuild_repository

Gentoo Haskell project
**********************

Getting involved
================

Oh, hi! So you've got a couple of moments to kill and you're looking for
something to do? You've come to the right place.

There are several ways to find tasks. One is looking in our `TODO list`_.
Another is to have a look at the `bug reports` piled up at the Gentoo
Bugzilla. Anything from actually solving the problem, to just verifying the
report, or providing more information is helpful.

To start contributing, you need a working copy of the Haskell overlay; a copy
that you can modify and send patches/pull requests from. You could use layman
to get a copy, but in this case we'd not recommend it. Assuming you have git
emerged, run this to get your own copy of the repo::

    git clone https://github.com/gentoo-haskell/gentoo-haskell.git

You need to be able to make patches, and send patches/pull requests on github.
If you are new to git try to read `some git basics`_ and drop in on
ircs://irc.libera.chat/#gentoo-haskell to get help.

.. _TODO list: TODO.rst
.. _bug reports: http://tinyurl.com/2l3p48
.. _some git basics: https://git-scm.com/book/en/v2 

Introduction to Haskell Ebuilds
===============================

We have two kinds of ebuilds: completely manually written ones, and ones mostly
generated from hackage using our custom tool, `hackport`_.

Ebuilds for complex applications and libraries that need a little more care,
like ghc, are written by hand.

The great majority, though, are `projects listed on the hackage site`. For all
those packages, we can generate ebuilds that often require very little
manual tweaking. The ebuild is generated from the dependencies, descriptions,
etc., described in the project's ``.cabal`` file. The progress of hackage and
its development decisions are important for gentoo haskell, which is why we
keep a close cooperation with them.

To get the hackport tool, either install ``app-portage/hackport-9999``
available from the haskell overlay, or get your copy of the repo using ::

    git clone https://github.com/gentoo-haskell/hackport.git

See `HOWTO contribute`_ for info on technical aspects of how to work with the
overlay.

.. _hackport: http://github.com/gentoo-haskell/hackport
.. _projects listed on the hackage site:
    http://hackage.haskell.org/packages/archive/pkg-list.html
.. _HOWTO contribute: HOWTO-contribute.rst

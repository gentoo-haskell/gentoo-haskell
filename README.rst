Gentoo Haskell project intro
****************************

Oh, hi!
So you've got a couple of moments to kill and you're looking for something
to do? You've come to the right place.

There are sereval ways to find tasks, one is looking in our `TODO list <projects/doc/TODO.rst>`_.
Another is to have a look at the bug reports piled up at
`the Gentoo Bugzilla <http://tinyurl.com/2l3p48>`_.
Anything from actually solving the problem to just verify the report or
provide more information is helpful.

To start contribute you need a working copy of the haskell overlay, a copy
that you can modify and send patches/pull requests from. You could use layman to get a
copy, but in this case I'd not recommend it. Assuming you have git emerged,
run this to get your own copy of the repo:

    git clone https://github.com/gentoo-haskell/gentoo-haskell.git

You need to be able to create patches and send patches/pull requests on github.
If you are new to git try to read `some basics <http://progit.org/book/>`_
and drop on freenode://#gentoo-haskell to get help.

Introduction to Haskell Ebuilds
===============================

We have two kinds of ebuilds, completely manually written, and those mostly
generated from hackage using our custom tool hackport.

Ebuilds for complex applications and libraries that take a little more care,
like ghc, are written by hand.

The absolutely mostpart though, are projects listed on the
`hackage site <http://hackage.haskell.org/packages/archive/pkg-list.html>`_.
For all those packages we can generate ebuilds that often only require very
little manual tweeking. The dependencies, descriptions etc, written in the
``.cabal`` files is used to correctly generate the ebuilds. The progress of
hackage and development decisions are important for gentoo haskell, which is
why we keep a close cooperation with them.

To get the hackport tool, either install ``app-portage/hackport-9999``
available from the haskell overlay, or get your copy of the repo using

  git clone https://github.com/gentoo-haskell/hackport.git

See `HOWTO contribute <projects/doc/HOWTO-contribute.rst>`_ on technical aspects of
how to work with overlay.

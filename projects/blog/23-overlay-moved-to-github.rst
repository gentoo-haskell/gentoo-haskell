We have moved gentoo-haskell overlay to `github <http://github.com/gentoo-haskell>`_!

It will require some additional actions for overlay users:

::

    layman -f
    layman -d haskell
    layman -a haskell

Our move was stimulated by a couple of events:

- code.haskell.org was not very reliable, and

- as you might notice `haskell overlay <http://code.haskell.org/gentoo/gentoo-haskell/>`_
  was (and still is) inaccessible since last week.
  Current status of code.haskell.org can be tracked
  `here <http://osdir.com/ml/haskell-cafe@haskell.org/2011-02/msg00042.html>`_.

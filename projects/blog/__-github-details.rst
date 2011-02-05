Gentoo Haskell recently moved to using git on github_.

We had various repositories, some larger with several contributors and some
smaller with only one developer.

Overlay repository
------------------

Main repo, commits from many users.
``darcs-fastconvert`` XXX made patch upstream

hackport
--------

originaly a fork from our main repo.

filter-branch_


::

  git filter-branch --tree-filter 'rm -rf foo baz bar' HEAD
  git filter-branch --prune-empty -f

keyword-stat
------------

straight forward ``darcs-fastconvert export``

.. _github: http://gentoohaskell.wordpress.com/2011/02/03/gentoo-haskell-overlay-moved-to-github/
.. _filter-branch: http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html

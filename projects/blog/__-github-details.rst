The Gentoo Linux Haskell Project recently moved to using git on github_.

We've got various repositories, some larger with several contributors and some
smaller with only one developer. All repos were based on the darcs_ revision
control system.

You may browse the new repos at our new `home <https://github.com/gentoo-haskell>`_.

Overlay repository
------------------

The overlay repository is the heart of the `Gentoo Linux Haskell Project`_. 

Main repo, commits from many users.
``darcs-fastconvert`` XXX made patch upstream

hackport
--------

hackport is the tool we use to generate Gentoo ebuilds from Hackage
packages. It geatly simplifies the process and enables us to cover hundreds
of packages with relatively few developers.

The hackport project started off as part of the overay repository in 2005.
At some point we decided that it deserved its own repository, as it really
was a standalone project. The development was forked from the overlay
repository, and continued without being mixed with the overlay commits.
However, the result was a repository with an messy history: hackport and
overlay stuff was mixed. Moving to git gave us a new chanse to clean it up.

When using git you have the option of changeing the history of your
repository. Of course this is a powerful tool, but it should be used
carefully. As we were in a transition of moving to git, we used these
advantages. In general git will require greater knowledge of your
consequences than similar tools (darcs, mercurial).

For this job we used the features of ``git filter-branch``, see
the git documentation at filter-branch_. As the projects where clearly
separated it was easy to tell git wich files were interesting:

::

  git filter-branch --tree-filter 'rm -rf ignore-this-file and-this-directory' HEAD
  git filter-branch --prune-empty -f

We repeated until we've cleared the history from the overlay commits. The
result is clean and only contains the hackport project. You find it at hackport_.

This way we could separate the ~400 commits from the ~1100 commits that had
nothing to do with the hackport project.

keyword-stat
------------

``keyword-stat`` is a tool to help us see the status of packages regarding
Gentoo's concept of stable and testing status. Each Gentoo user is able to
choose the stability level of each package through the keywording_ concept.

The repo was already at a nice state and the conversion was straight forward:

::

  mkdir keyword-stat.git
  cd keyword-stat.git
  git init
  ( cd ../keyword-stat ; darcs-fastconvert export ) || git fast-import

.. _Gentoo Linux Haskell Project: http://www.gentoo.org/proj/en/prog_lang/haskell/index.xml
.. _darcs: http://darcs.net/
.. _github: http://gentoohaskell.wordpress.com/2011/02/03/gentoo-haskell-overlay-moved-to-github/
.. _filter-branch: http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
.. _hackport: https://github.com/gentoo-haskell/hackport
.. _keywording: http://devmanual.gentoo.org/keywording/index.html

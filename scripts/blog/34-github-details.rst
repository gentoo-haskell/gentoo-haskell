The Gentoo Linux Haskell Project recently moved to using git on github_.

We've got various repositories, some larger with several contributors and some
smaller with only one developer. All repos were based on the darcs_ revision
control system.

You may browse the new repos at our new `home <https://github.com/gentoo-haskell>`_.

Overlay repository
------------------

The overlay repository is the heart of the `Gentoo Linux Haskell Project`_.
The most common packages are available in the portage tree, and thus
available to all Gentoo Linux users without any additional configuration on
their part.

For all other packages we use the overlay. It can be packages that change
rapidly, are tricky to build, etc.

It's our main repo, ~4000 commits from many users. There was two tools to
consider: 

- darcs-fastconvert_ written in haskell
- darcs-to-git_ written in ruby

We've decided to try both.

darcs-to-git
''''''''''''

::

  mkdir overlay.git && cd overlay.git
  darcs-to-git ../overlay
  git commit --allow-empty -m "phony" # hack, described later
  darcs-to-git ../overlay

The hack with --allow-empty is used to workaround an error:

::

  Running: ["git", "log", "-n1", "--no-color"]
  fatal: bad default revision 'HEAD'

git does not track directory creation commits (when no files are affected).
It's our first commit. To be reported upstream.

``darcs-to-git`` took 7.5 hours(!) to convert our repo.

darcs-fastconvert
'''''''''''''''''

::

  mkdir overlay.git && cd overlay.git
  (cd ../overlay ; darcs-fastconvert export) | git fast-import

It was very fast! Took less, than 7 minutes to convert everything (~60 times
faster than ``darcs-to-git``!)

some notes
''''''''''

- ``darcs-fastconvert`` does not try to make prettier email-only usernames:

  username 'john@doe' becomes 'john@doe <unknown>'. Patch to convert such names
  to 'john <john@doe>' sent upstream (left copy `here <http://dev.gentoo.org/~slyfox/darcs-fastconvert-email-only-author.patch>`_).

- ``darcs-fastconvert`` does not filter out empty commits (directory-adding in darcs), so in order
  to get the same amount of commits as for ``darcs-to-git`` you will need to run
  ``git filter-branch --prune-empty -f``

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
overlay stuff was mixed. Moving to git gave us a new chance to clean it up.

When using git you have the option of changing the history of your
repository. Of course this is a powerful tool, but it should be used
carefully. As we were in a transition of moving to git, we used these
advantages. In general git will require greater knowledge of your
consequences than similar tools (darcs, mercurial).

For this job we used the features of ``git filter-branch``, see
the git documentation at filter-branch_. As the projects where clearly
separated it was easy to tell git which files were interesting:

::

  git filter-branch --tree-filter \
        'rm -rf ignore-this-file and-this-directory' HEAD
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

  mkdir keyword-stat.git && cd keyword-stat.git
  git init
  ( cd ../keyword-stat ; darcs-fastconvert export ) \
      | git fast-import

.. _Gentoo Linux Haskell Project: http://www.gentoo.org/proj/en/prog_lang/haskell/index.xml
.. _darcs: http://darcs.net/
.. _github: http://gentoohaskell.wordpress.com/2011/02/03/gentoo-haskell-overlay-moved-to-github/
.. _darcs-fastconvert: http://hackage.haskell.org/package/darcs-fastconvert
.. _darcs-to-git: https://github.com/purcell/darcs-to-git
.. _filter-branch: http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
.. _hackport: https://github.com/gentoo-haskell/hackport
.. _keywording: http://devmanual.gentoo.org/keywording/index.html

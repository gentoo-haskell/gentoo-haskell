Ebuild hacking tips
*******************

This doc tries to cover nice tricks to
make seasoned overlay hackers a bit easier.

Basic repo sanity check
=======================

When hacking on ebuilds it's common to forget to add
newly created files in repository, or rerun ``pkgdev manifest``
after treewide change. We have ``lambdaman`` tool for it.

See ``projects/lambdaman/REAMDE`` to plug it as
pre-commit hook.

Advanced eclass variables
=========================

``haskell-cabal.eclass`` has some undocumented but very nice
to use variables:

HCFLAGS
~~~~~~~

The ``HCFLAGS`` is a list of compiler options passed to ``ghc``.
Make something creative with it! I'm using``-Wall`` on my box
but you might try to screw things a bit more and add ``-O2`` there.

It's a nice thing to do one-off fast compile tests like::

    HCFLAGS=-O0 emerge -1 darcs

CABAL_EXTRA_BUILD_FLAGS
~~~~~~~~~~~~~~~~~~~~~~~

Sometimes it is nice to see detailed build log for some cabal package:
``haddock`` parameters, ``hsc2hs`` parameters and things like that.
You either can do it manually by running ``./setup build -v`` out of
source tree or just use ``CABAL_EXTRA_BUILD_FLAGS``::

    CABAL_EXTRA_BUILD_FLAGS=-v HCFLAGS=-O0 emerge -1 faulty-package

Gitify your ebuilds in prepare phase
====================================

When you plan to patch some random ebuild it is
handly to keep unpacked source tree under some SCM.
I use git for example. Here is my ``/etc/portage/bashrc``::

    # cat /etc/portage/bashrc
    git_commit_current_state() {
        [[ -z $GITIFY ]] && return
        pushd "${S}"
        if [ ! -d .git ]; then
                git init .
        fi
        git config user.name "Sergei Trofimovich"
        git config user.email "slyfox@gentoo.org"
        git add .
        git commit -a -s -m "$@"
        popd
    }

    post_src_unpack() {
        git_commit_current_state "state after src_unpack()"
    }

    post_src_prepare() {
        git_commit_current_state "state after src_prepare()"
    }

Then you might like to use it as::

    GITIFY=yes HCFLAGS=-O0 ebuild path/to/xmonad-0.10.ebuild clean prepare compile
    # 0. assume build has failed
    cd /var/tmp/portage/x11-wm/xmonad-0.10/work
    # 1. fix
    # 2. ebuild path/to/xmonad-0.10.ebuild compile
    # 3. test / loop 1.
    git diff > ~/xmonad-0.10-unb0rked.patch
    # 4. fix ebuild

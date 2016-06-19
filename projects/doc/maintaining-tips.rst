Haskell ebuild maintaining tips
*******************************

Check `Gentoo devmanuall <https://devmanual.gentoo.org/>`_ for general
guidance on ebuild writing. This doc is about haskell-specific aspects of it.

Slot operator dependencies
==========================

Haskell packages use slot operator dependencies: `dev-haskell/foo:=`
(or `dev-haskell/foo:${slotname}=` to force rebuild of a package every
time `dev-haskell/foo` updates. It requires `EAPI=5` and upper.

The rebuild is needed as GHC haskell ABI is very precise(or fragile :):
package changes ABI every time package's version, interface hashes
(`.hi` files) or detendency packages change.

The `:=` is not enough to make sure system does not get into a broken state.
Consider an example: user has 3 packages installed depending on one another:

.. code-block::

    darcs:RDEPEND="text:=" SLOT=0/${PV}

    text:RDEPEND="binary:=" SLOT=0/${PV}

    binary:RDEPEND="" SLOT=0/${PV}

Suppose binary will get an update: `binary-0` -> `binary-1`. That
will trigger a subslot rebuild for `text`. As a result ABI will be
changed for packages `binary` and `text`. `text` package won't change
it's subslot as there was no new `text` ebuild. Thus `darcs` package
will be left in broken state.

There is no easy fix for it. We need something that transitively
can flag ABI as changed: `feature request <https://bugs.gentoo.org/449094>`_.

Upper bounds
============

Haskell upstreams usually adhere to `Package versioning policy <https://wiki.haskell.org/Package_versioning_policy>`_
and guard upper bounds of used dependencies in their packages.

.. code-block:: haskell

    -- somewhere in cheapskate.cabal
    library
      hs-source-dirs:  .
      build-depends:   base >=4.4 && <5,
                       containers >=0.4 && <0.6,
                       mtl >=2.1 && <2.3,
                       text >= 0.9 && < 1.3,
                       blaze-html >=0.6 && < 0.10,
                       xss-sanitize >= 0.3 && < 0.4,
                       data-default >= 0.5 && < 0.7,

That means once you have added (say) `data-default-0.7` to the tree
those package will not be able to use it and will try to keep
older version installed for users of `cheapskate`.

It causes portage show warnings during upgrade at best and cryptic
slot conflicts at worst:

.. code-block::

    !!! Multiple package instances within a single package slot have been pulled
    !!! into the dependency graph, resulting in a slot conflict:
    dev-haskell/data-default:0
      (dev-haskell/data-default-0.7.0:0/0.7.0::haskell, ebuild scheduled for merge) pulled in by
        >=dev-haskell/data-default-0.6.0:=[profile?] required by (dev-haskell/bcrypt-0.0.9:0/0.0.9::haskell, ebuild scheduled for merge)
        ^^                         ^^^^^
      (dev-haskell/data-default-0.5.3:0/0.5.3::haskell, installed) pulled in by
        dev-haskell/data-default:0/0.5.3=[profile] required by (dev-haskell/gravatar-0.8.0:0/0.8.0::haskell, installed)
                                ^^^^^^^^^
        dev-haskell/data-default:0/0.5.3=[profile] required by (dev-haskell/keter-1.4.3.1-r1:0/1.4.3.1::haskell, installed)
                                ^^^^^^^^^
        <dev-haskell/data-default-0.6:=[profile?] required by (dev-haskell/fay-0.23.1.12-r4:0/0.23.1.12::haskell, installed
        ^                         ^^^ ^
        <dev-haskell/data-default-0.7:=[profile?] required by (dev-haskell/cheapskate-0.1.0.5:0/0.1.0.5::haskell, installed
        ^                         ^^^ ^

`haskell-cabal.eclass` provides a helper function to patch`.cabal` files in the following style:

.. code-block:: bash

    # somewhere in dev-haskell/cheapskate-0.1.0.5.ebuild
    #
    RDEPENDS=">=dev-haskell/data-default-0.5:=[profile?]" # removed upper bound here
    ...
    src_prepare() {
        default
        
        cabal_chdeps \
            'data-default >= 0.5 && < 0.7' 'data-default >= 0.5'
    }

Don't forget to revbump an ebuild after you change RDEPENDs.
Otherwise package manager will not try to update installed package
and will keep old upper bound.

.. code-block:: bash

    $ git mv cheapskate-0.1.0.5.ebuild cheapskate-0.1.0.5-r1.ebuild

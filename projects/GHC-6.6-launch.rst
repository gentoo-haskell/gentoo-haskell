==============
GHC 6.6 Launch
==============

:Author: Lennart Kolmodin <kolmodin@gentoo.org>,
         Gentoo Haskell Herd <haskell@gentoo.org>
:Updated: 2007-07-23

.. sectnum::

Due to the restructure of bundled libraries from GHC 6.4 -> 6.6 we've had to
rewrite ebuild dependencies between packages and libraries. While doing this
we have also taken the chance to do some updates we've been ponding on in
the past.

This document describes some background on what's new in GHC 6.6 and the
plan that has been carefully crafted on how to deal with it.

We have tried to summarize what the Gentoo Haskell Heard has been up to the
past months (or year...).

Introduction
============

In GHC 6.4 a lot of packages where bundled with the compiler. In GHC 6.6
this has changed, all but the packages used by the compiler itself are now
available as a separate download. That bundle is called ghc-extralibs.

This makes the GHC installation much faster, as you only compile the libs
you need. Also, it gives the advantage that when you'd like to update a
library, you only have to recompile exactly that one, instead of recompiling
everything like before.

We have also merged the dev-lang/ghc-bin package into the dev-lang/ghc
package, which you can get by using ``USE=binary``. The ghc-bin tarball is
used to bootstrap the source ghc compiler, instead of relying on a
preinstalled compiler.

This can be modeled in Gentoo Linux' package management system, as
we'll see next.


The plan
========

Each library in the ghc-extralibs will be represented by a separate
package in the tree. Packages that can be compiled with GHC 6.6 (possibly
also GHC 6.4) should depend on the modular libraries.

To mirror this behavior for GHC 6.4 where the compiler already provides the
libraries, we use dummy libraries as place holders. They will not do or
install anything, but merely exist to depended upon by packages that need
those libraries. The dummy libraries will only depend on the GHC 6.4
compiler, while the real modular libs will depend on the GHC 6.6 series or
newer. If an application/library is compiled against GHC 6.4 the dummy
libraries will be used, and in the case of GHC 6.6 the modular libraries.
This way it'll be easy to write the ebuilds, just depend on the libraries
you need, regardless of compiler version.

Note though, packages that cannot be built with GHC 6.6 doesn't gain
anything from depending on the modular libraries, as they are guarantied to
all be dummy libraries. Thus there should be no requirement for those
packages to use the modular libs.


Why merge ghc and ghc-bin?
==========================

It makes dependienceies simpler...::

    DEPEND="=virtual/ghc-6.4* !>=virtual/ghc-6.6"


Assume the user has ghc-bin-6.4.2 which he (or she!) used to compile
ghc-6.4.2, and then one day installs ghc-6.6. The first dependency will be
satisfied by ghc-bin-6.4.2, but it's actually ghc-6.6 that's going to be
used to compile the package! (as ghc has precedence to ghc-bin). The block
makes sure this doesn't happen.

With ghc only available as one package, you can simply say::

    DEPEND="=dev-lang/ghc-6.4*"

Step by step
============

The proposed actions of the scheme are listed below.


Add GHC 6.6 to the tree
-----------------------

This was done 7 March. It's p.masked.

ghc-bin
-------

Update 2007-03-16: ghc-bin-6.6 in the tree, ~amd64 ~x86

Update 2007-04-12: cparrot has added ~alpha, ~ppc and ~sparc

Update 2007-07-23: the ghc-bin tarballs are usable, but the packages will go
                   away.

Add modular libs
----------------

Ie, only the modular libs from ghc-extralibs meant for GHC 6.6. They should
also be p.masked.

Modular libs has been added for:

* dev-haskell/arrows
* dev-haskell/cgi
* dev-haskell/fgl
* dev-haskell/haskell-src
* dev-haskell/html
* dev-haskell/hunit
* dev-haskell/mtl
* dev-haskell/network
* dev-haskell/quickcheck
* dev-haskell/time
* dev-haskell/xhtml
* dev-haskell/alut
* dev-haskell/glut
* dev-haskell/openal
* dev-haskell/opengl

Still missing for:

* dev-havkell/hgl

Add dummy libs
--------------

The about 15 packages of ghc-extralibs has to be modeled as dummy libs
too. They should be added as ~arch and then be stabilized by the arch teams
asap.

The most common libs where added the 11th March, and have been marked as
~arch or stable on 2007-04-02:

* dev-haskell/fgl-5.2
* dev-haskell/mtl-1.0
* dev-haskell/haskell-src-1.0
* dev-haskell/html-1.0
* dev-haskell/hunit-1.1
* dev-haskell/network-1.0
* dev-haskell/quickcheck-1.0

Dummies missing, just as all dummies, they only has to be added if an ebuild
depends on that functionality:

* dev-haskell/alut
* dev-haskell/glut
* dev-havkell/hgl
* dev-haskell/openal
* dev-haskell/opengl

Start rewrite other libs and apps to use the dummy libs
-------------------------------------------------------

This is only required for applications that can be compiled with GHC 6.6, as
described above.

Packages that today are marked as stable and can be compiled with GHC 6.6
requires that the dummy libraries are marked as stable too. Thus we have to
start rewriting the other packages until the dummys has been marked stable.


Make new libs use the p.masked modular libs
-------------------------------------------

Packages that only compiles with GHC 6.6 can be added to, if p.masked.

p.unmasking
-----------

* update ghc-6.6.1 ebuild in portage from the overlay version
* update ghc and cabal eclasses in portage from the overlay versions
* merge any changes in the modular libs from the overlay
* unmask ghc-6.6.1 and associated modular libs
* put combined ghc-6.4.2 and 6.2.2 ebuilds into portage
* mask ghc-bin asking people to move to ghc with USE=binary
* make all other ebuilds depend on dev-lang/ghc rather than virtual/ghc
* remove ghc-bin and the ghc virtual

..
    cleaned up conversation from 2007-03-01
    20:15 < dcoutts_> sure sure
    20:15 < dcoutts_> so we should add dummy packages now
    20:15 < dcoutts_> I think at the same time we should get ghc-6.6 into portage p.masked
    20:16 < dcoutts_> so at least the arch teams will see our plan
    20:16 < dcoutts_> and the necessity to mark the dummy things stable
    20:16 < dcoutts_> and it'll make it easier to test things in the context of portage rather than the overlay
    20:16 < dcoutts_> we could also add new libs p.masked
    20:16 < dcoutts_> whatever
    20:17 < dcoutts_> actually if new libs work with 6.4 they can dep on the modular libs and things should work
    20:17 < dcoutts_> since the dummys will be ~arch for a while
    20:18 < dcoutts_> so they would not need to be p.masked, only things which require 6.6 would need to be p.masked
    20:18 < dcoutts_> like the non-dummy versions of the modular libs
    20:19 < dcoutts_> so lets clarify.. what can we do now without the arch team's involvement?
    20:19 < dcoutts_> 1. we can add the dummy modular libs packages in ~arch
    20:19 < dcoutts_> 2. we can add ghc-6.6 p.masked
    20:19 < dcoutts_> 3. we can add the real modular libs packages in p.mask
    20:20 < dcoutts_> (note: so far no existing packages changed)
    20:21 < dcoutts_> 4. new ~arch versions of libs/progs can dep on the dummy libs
    20:21 < dcoutts_> 5. new p.masked versions of libs/progs can dep on ghc-6.6 and real libs
    20:21 < dcoutts_> then I think we have to wait
    20:21 < dcoutts_> we have to get the dummy libs stable
    20:21 < dcoutts_> and modify existing packages to dep on them
    20:23 < dcoutts_> so once the existing packages are depending on the modular libs, and are all patched up to work with ghc-6.6...
    20:23 < dcoutts_> then we can unmask ghc-6.6 and the other libs depending on it
    20:23 < dcoutts_> how about that?
    20:23 < dcoutts_> so we never need to mark existing packages as <ghc-6.6
    20:23 < dcoutts_> on the other hand it takes a bit longer to unmask 6.6
    20:24 < dcoutts_> the other strategy is to unmask 6.6 earlier but modify existing packages to <ghc-6.6
    20:24 < dcoutts_> that's not ideal since people upgrading will then not be able to update their existing packages
    20:24 < dcoutts_> ie we'd break things
    20:25 < dcoutts_> kolmodin, might want to copy it, edit it, and put it in portage as .txt/.html or something
    20:25 < dcoutts_> and revise it as we refine/agree the plan
    20:25 < kolmodin> aye, good idea
    20:25 < dcoutts_> then we can get on with it without having to keep referring to each other about what the plan was :-)

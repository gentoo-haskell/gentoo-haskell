==============
GHC 6.6 Launch
==============

:Author: Lennart Kolmodin <kolmodin@gentoo.org>,
         Gentoo Haskell Herd <haskell@gentoo.org>
:Updated: 2007-03-10

.. sectnum::

Due to the restructure of bundled libraries from GHC 6.4 -> 6.6 we've had to
rewrite ebuild dependencies between packages and libraries.

This document describes some background on what's new in GHC 6.6 and the
plan that has been carefully crafted on how to deal with it.

I have tried to summarize what the Gentoo Haskell Heard has been up to the
past months.

Introduction
============

In GHC 6.4 a lot of packages where bundled with the compiler. In GHC 6.6
this has changed, all but the packages used by the compiler itself are now
available as a separate download. That bundle is called ghc-extralibs.

This makes the GHC installation much faster, as you only compile the libs
you need. Also, it gives the advantage that when you'd like to update a
library, you only have to recompile exactly that one, instead of recompiling
everything like before.

This can be modeled in Gentoo Linux' package management system, as
we'll see next.


The plan
========

Each library in the ghc-extralibs will be represented by a separate
package in the tree. Packages that can be compiled with GHC 6.6 (possibly
also GHC 6.4) should depend on the modular libraries.

To mirror this behavior for GHC 6.4 where the compiler already provides the
libraries, we use dummy libraries as place holders. They will not do or
install anything, but mearly exist to depended upon by packages that need
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

We won't use any dependency blocks to indicate when an ebuild can't be
compiled with GHC 6.6. Rather we'll use::

    DEPEND="<virtual/ghc-6.6"

to indicate that a package cannot be compiled with GHC 6.6. Similarly we'll
use::

    DEPEND="=virtual/ghc-6.4*"

to indicate when a package only can be compiled with the GHC 6.4 series.

..
  Why don't we use blocks? There was a good reason for this but I've forgot
  it.

As many packages has been changed recently, it's recommended that once this
plan is implemented, users that have used the Gentoo Haskell overlay should
remove their packages and install fresh from the tree.

Step by step
============

The proposed actions of the scheme are listed below.


Add GHC 6.6 to the tree
-----------------------

This was done 7 March. It's p.masked.

ghc-bin
-------

ghc-bin-6.6 must be in the tree before unmasking of ghc-6.6 as emerge can't
bootstrap ghc-6.6 unless there is a version of ghc already installed.
I't a good idea anyway.

Update 2007-03-16: ghc-bin-6.6 in the tree, ~amd64 ~x86

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

Still missing for:

* dev-haskell/alut
* dev-haskell/glut
* dev-havkell/hgl
* dev-haskell/openal
* dev-haskell/opengl

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

Dummies missing:

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

All p.masked packages can be unmasked when:

1. ghc-bin-6.6 is in the tree
#. All packages that can be compiled with GHC 6.6 is updated to modular deps
#. We're confident with the testing

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

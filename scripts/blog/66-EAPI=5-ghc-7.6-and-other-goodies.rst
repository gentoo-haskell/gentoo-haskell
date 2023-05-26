:PostID: 66
:Title: EAPI=5, ghc-7.6 and other goodies
:Keywords: gentoo, ghc, overlay
:Categories: news

Today I have unmasked **ghc-7.6.1** in **gentoo**'s **haskell** overlay.
Quite a few of things is broken (like unbumped yet **gtk2hs**),
but major things (like darcs) seem to work fine. Feel free to drop
a line on **#gentoo-haskell** to get the thing fixed.

Some notes and events in the overlay:

- **ghc-7.6.1** is available for all major arches we try to support
- a few ebuilds of overlay were converted to **EAPI=5** to use subslot
  depends (see below)
- we've got **working** **ghc-9999** ebuild with shared libraries by default! (see below)

.. raw:: html

   <!--more-->

ghc-7.6
-------

That beast brought two major problems to it's users:

1. Prelude.catch gone away and is called 'System.IO.Error.catchIOError' now
2. **directory** package broke interface to existing function 'getModificationTime' without
   old compatible variant.

While the first breakage is easy to fix by something like:

::

    #if MIN_VERSION_base(4,6,0)
    catch :: IO a -> (IOError -> IO a) -> IO a
    catch = System.IO.Error.catchIOError

(or just switch to **extensible-exceptions** package if you need
support for really old ghc versions).

The second one is literally a `disaster <https://github.com/ghc/packages-directory/commit/d0cab4bb327910a341bc99f4e8539806bd671a11>`_

::

    -getModificationTime :: FilePath -> IO ClockTime
    +getModificationTime :: FilePath -> IO UTCTime

It is not as straightforward and "fixes" in various packages
break PVP in a very funny way.

Look at `this example<https://github.com/willdonnelly/dyre/commit/7755c6ef1c443737006ff5a4a8bf374a00b77bca>`_.

Now that package has random signature type depending
on which **directory** version it decided to build against.

TODO: find a nice and simple ':: ClockTime -> IO UTCTime' compatibility
function to end that keep creeping mess. (I wish the **directory** package
to provide that).

Okay. Enough ranting.

EAPI=5
------

Some of experienced gentoo haskell users already know
about the magic **haskell-updater** tool written by Ivan
to fix the mess after ghc upgrade or some base library
upgrade.

Typical symptom of broken libraries is the similar
``ghc-pkg check`` result:

::

    There are problems in package data-accessor-monads-fd-0.2.0.3:
      dependency "monads-fd-0.1.0.4-830f79a91000e99707aac145b972f786" doesn't exist
    There are problems in package LibZip-0.10.2:
      dependency "mtl-2.0.1.0-b1b6de8085e5ea10cc0eb01054b69110" doesn't exist
    There are problems in package jail-0.0.1.1:
      dependency "monads-fd-0.1.0.4-830f79a91000e99707aac145b972f786" doesn't exist

Why it happens?

Well, ghc's library **ABI** depends on ABIs on all the libraries it uses.
It has quite nasty consequences.

Once you upgrade a library you need to:

1. rebuild all the reverse dependencies
2. and their reverse dependencies (recursive)

The first point can be solved by **EAPI 5** so
called `SUBSLOT feature <http://wiki.gentoo.org/wiki/Sub-slots_and_Slot-Operators>`_.

The second one is not solved yet, but i was said is planned for **EAPI=6**.
Thus you will still need to use **haskell-updater** time to time.

Anyway, I've bumped **binary** package today and to show how portage
picks all it's immediate users:

::

    # emerge -av1 dev-haskell/binary
    
    These are the packages that would be merged, in order:
    
    Calculating dependencies... done!
    [ebuild  r  U ~] dev-haskell/binary-0.6.4.0:0/0.6.4.0::gentoo-haskell [0.6.2.0:0/0.6.2.0::gentoo-haskell] USE="doc hscolour {test} -hoogle -profile" 0 kB
    [ebuild  r  U ~] dev-haskell/sha-1.6.1:0/1.6.1::gentoo-haskell [1.6.0:0/1.6.0::gentoo-haskell] USE="doc hscolour -hoogle -profile" 2,651 kB
    [ebuild  r  U ~] dev-haskell/zip-archive-0.1.2.1-r2:0/0.1.2.1::gentoo-haskell [0.1.2.1-r1:0/0.1.2.1::gentoo-haskell] USE="doc hscolour {test} -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/data-binary-ieee754-0.4.3:0/0.4.3::gentoo-haskell  USE="doc hscolour -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/dyre-0.8.11:0/0.8.11::gentoo-haskell  USE="doc hscolour -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/hxt-9.3.1.1:0/9.3.1.1::gentoo-haskell  USE="doc hscolour -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/hashed-storage-0.5.10:0/0.5.10::gentoo-haskell  USE="doc hscolour {test} -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/dbus-core-0.9.3-r1:0/0.9.3::gentoo-haskell  USE="doc hscolour -hoogle -profile" 0 kB
    [ebuild  rR   ~] dev-haskell/hoogle-4.2.14:0/4.2.14::gentoo-haskell  USE="doc fetchdb hscolour -fetchdb-ghc -hoogle -localdb -profile" 0 kB
    [ebuild  rR   ~] www-apps/gitit-0.10.0.2-r1:0/0.10.0.2::gentoo-haskell  USE="doc hscolour plugins -hoogle -profile" 0 kB
    [ebuild  r  U ~] dev-haskell/yesod-auth-1.1.1.7:0/1.1.1.7::gentoo-haskell [1.1.1.6:0/1.1.1.6::gentoo-haskell] USE="doc hscolour -hoogle -profile" 17 kB
    [ebuild  rR   ~] dev-haskell/yesod-1.1.4:0/1.1.4::gentoo-haskell  USE="doc hscolour -hoogle -profile" 0 kB
    
    Total: 12 packages (4 upgrades, 8 reinstalls), Size of downloads: 2,668 kB
    
    Would you like to merge these packages? [Yes/No]

I would like to rebuild all the **sha** (and so on) revdeps as well, but
**EAPI** can't express that kind of depends yet.

The **EAPI=5** ebuild slowly drift to main portage tree as well.

ghc-9999
--------

The most iteresting thing!

With great Mark's help we now have live ghc ebuild right out of
gti tree!

One of the most notable things is the dynamic linking by default.

::

    # ldd `which happy` # ghc-7.7.20121116
        linux-vdso.so.1 (0x00007fffb0bff000)
        libHScontainers-0.5.0.0-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/containers-0.5.0.0/libHScontainers-0.5.0.0-ghc7.7.20121116.so (0x00007fe616972000)
        libHSarray-0.4.0.1-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/array-0.4.0.1/libHSarray-0.4.0.1-ghc7.7.20121116.so (0x00007fe6166d0000)
        libHSbase-4.6.0.0-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/base-4.6.0.0/libHSbase-4.6.0.0-ghc7.7.20121116.so (0x00007fe615df9000)
        libHSinteger-gmp-0.5.0.0-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/integer-gmp-0.5.0.0/libHSinteger-gmp-0.5.0.0-ghc7.7.20121116.so (0x00007fe615be6000)
        libHSghc-prim-0.3.0.0-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/ghc-prim-0.3.0.0/libHSghc-prim-0.3.0.0-ghc7.7.20121116.so (0x00007fe615976000)
        libHSrts-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/rts-1.0/libHSrts-ghc7.7.20121116.so (0x00007fe615715000)
        libc.so.6 => /lib64/libc.so.6 (0x00007fe61536c000)
        libHSdeepseq-1.3.0.1-ghc7.7.20121116.so => /usr/lib64/ghc-7.7.20121116/containers-0.5.0.0/../deepseq-1.3.0.1/libHSdeepseq-1.3.0.1-ghc7.7.20121116.so (0x00007fe615162000)
        libgmp.so.10 => /usr/lib64/libgmp.so.10 (0x00007fe614ef4000)
        libffi.so.6 => /usr/lib64/libffi.so.6 (0x00007fe614cec000)
        libm.so.6 => /lib64/libm.so.6 (0x00007fe6149f2000)
        librt.so.1 => /lib64/librt.so.1 (0x00007fe6147ea000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007fe6145e6000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fe616d41000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fe6143ca000)
    
    $ ls -lh `which pandoc` # ghc-7.7.20121116
    -rwxr-xr-x 1 root root 6.3M Nov 16 16:38 /usr/bin/pandoc
    $ ls -lh `which pandoc` # ghc-7.4.2
    -rwxr-xr-x 1 root root 27M Nov 18 17:46 /usr/bin/pandoc

Actually, the whole **ghc-9999** installation is **150MB** smaller,
than **ghc-7.4.1** on amd64.

Quite a win!

And as a side effect **revdep-rebuild** (or portage's **FEATURES=preserved-rebuild**)
can note (and fix) introduced breakages due to upgrades!

Work on the ghc cross-compilation in the ebuild slowly continues (needs some upstream
fixes to support toolchains inferred from **build**/**host**/**target** triplets).

Have fun!

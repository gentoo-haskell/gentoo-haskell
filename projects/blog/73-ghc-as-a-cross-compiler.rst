:PostID: 73
:Title: GHC as a cross-compiler
:Keywords: gentoo, ghc, overlay, crosscompiler
:Categories: news

Another small breakthrough today for those who would
like to see **haskell** programs running.

Here is a small incomplete **HOWTO** for **gentoo**
users on how to build a crosscompiler running on
**x86_64** host targeted on **ia64** platform.

It is just an example. You can pick any target.

.. raw:: html

   <!--more-->

First of all you need to enable **haskell** overlay
and install host compiler:

::

    # GHC_IS_UNREG=yeah emerge -av =ghc-7.6.1

The **GHC_IS_UNREG=yeah** bit is critical. If we won't do it
**GHC** build system will try to build registerised **stage1**
(which is a crosscompiler already).

Not setting **GHC_IS_UNREG** will break for a set of problems:

- **GHC** will try to optimize generated bitcode with **llvm**'s
  optimizer which will produce **x86_64** instructions, not **ia64**.

- **GHC** will try to run (broken on **ia64**) object splitter
  perl script: **ghc-split.lprl**.

The rest is rather simple:

::

     # crossdev ia64-unknown-linux-gnu
     # ia64-unknown-linux-gnu-emerge sys-libs/ncurses virtual/libffi dev-libs/gmp
     # ln -s ${haskell_overlay}/haskell/dev-lang/ghc ${cross_overlay}/ia64-unknown-linux-gnu/ghc
     # cd ${cross_overlay}/ia64-unknown-linux-gnu/ghc
     # EXTRA_ECONF=--enable-unregisterised USE=ghcmakebinary ebuild ghc-9999.ebuild compile

It will fail as the following command tries to run **ia64** binary
on **x86_64** host:

::

    libraries/integer-gmp/cbits/mkGmpDerivedConstants > libraries/integer-gmp/cbits/GmpDerivedConstants.h

I've logged-in to **ia64** box and ran **mkGmpDerivedConstants**
to get a **GmpDerivedConstants.h**.
Added the result to the ${WORKDIR} and reran last command.

After the build has finished I've got corsscompiler:

::

    sf ghc-9999 # "inplace/bin/ghc-stage1" --info
     [("Project name","The Glorious Glasgow Haskell Compilation System")
     ,("GCC extra via C opts"," -fwrapv")
     ,("C compiler command","/usr/bin/ia64-unknown-linux-gnu-gcc")
     ,("C compiler flags"," -fno-stack-protector  -Wl,--hash-size=31 -Wl,--reduce-memory-overheads")
     ,("ld command","/usr/bin/ia64-unknown-linux-gnu-ld")
     ,("ld flags","     --hash-size=31     --reduce-memory-overheads")
     ,("ld supports compact unwind","YES")
     ,("ld supports build-id","YES")
     ,("ld is GNU ld","YES")
     ,("ar command","/usr/bin/ar")
     ,("ar flags","q")
     ,("ar supports at file","YES")
     ,("touch command","touch")
     ,("dllwrap command","/bin/false")
     ,("windres command","/bin/false")
     ,("perl command","/usr/bin/perl")
     ,("target os","OSLinux")
     ,("target arch","ArchUnknown")
     ,("target word size","8")
     ,("target has GNU nonexec stack","True")
     ,("target has .ident directive","True")
     ,("target has subsections via symbols","False")
     ,("Unregisterised","YES")
     ,("LLVM llc command","llc")
     ,("LLVM opt command","opt")
     ,("Project version","7.7.20130118")
     ,("Booter version","7.6.1")
     ,("Stage","1")
     ,("Build platform","x86_64-unknown-linux")
     ,("Host platform","x86_64-unknown-linux")
     ,("Target platform","ia64-unknown-linux")
     ,("Have interpreter","NO")
     ,("Object splitting supported","NO")
     ,("Have native code generator","NO")
     ,("Support SMP","NO")
     ,("Tables next to code","NO")
     ,("RTS ways","l debug  thr thr_debug thr_l thr_p ")
     ,("Dynamic by default","NO")
     ,("Leading underscore","NO")
     ,("Debug on","False")
     ,("LibDir","/var/tmp/portage/cross-ia64-unknown-linux-gnu/ghc-9999/work/ghc-9999/inplace/lib")
     ,("Global Package DB","/var/tmp/portage/cross-ia64-unknown-linux-gnu/ghc-9999/work/ghc-9999/inplace/lib/package.conf.d")
     ]

    # cat a.hs
    main = print 1
    # "inplace/bin/ghc-stage1" a.hs -fforce-recomp -o a
    [1 of 1] Compiling Main             ( a.hs, a.o )
    Linking a ...
    # file a
    a: ELF 64-bit LSB executable, IA-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.16, not stripped
    # LANG=C ls -lh a
    -rwxr-xr-x 1 root portage 24M Jan 20 02:24 a
    on ia64:
    $ ./a
    1

Results:

- It's not that hard to build a ghc with some exotic target
  if you have gcc there.

- **mkGmpDerivedConstants** needs to be more cross-compiler friendly
  It should be really simple to implement, it only queries for data sizes/offsets.
  I think autotools is already able to do it.

- **GHC** should be able to run llvm with correct **-mtriple**
  in crosscompiler case. That way we would get registerised crosscompiler.

Some TODOs:

In order to coexist with native compiler ghc should stop mangling
----target=ia64-unknown-linux-gnu option passed by user and name
resulting compiler a ia64-unknown-linux-gnu-ghc and not ia64-unknown-linux-ghc.

That way I could have many flavours of compiler for one target.
For example I would like to have x86_64-pc-linux-gnu-ghc as a registerised
compiler and x86_64-unknown-linux-gnu-ghc as an unreg one.

And yes, they will all be tracked by **gentoo's** package manager.

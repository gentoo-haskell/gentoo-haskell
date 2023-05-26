:PostID: 153
:Title: GHC as a cross-compiler update
:Keywords: gentoo, haskell, ghc, crosscompiler, crossbuilding, qemu
:Categories: notes

TL;DR:
======

Gentoo's **dev-lang/ghc-8.2.1_rc1** supports both cross-building
and cross-compiling modes! It's useful for cross-compiling haskell
software and initial porting of **GHC** itself on a new gentoo target.

Building a GHC crossompiler on Gentoo
=====================================

Getting **${CTARGET}-ghc** (crosscompiler) on **Gentoo**:

.. code-block:: bash

    # # convenience variables:
    CTARGET=powerpc64-unknown-linux-gnu
    #
    # # Installing a target toolchain: gcc, glibc, binutils
    crossdev ${CTARGET}
    # # Installing ghc dependencies:
    emerge-${CTARGET} -1 libffi ncurses gmp
    #
    # # adding 'ghc' symlink to cross-overlay:
    ln -s path/to/haskell/overlay/dev-lang/ghc part/to/cross/overlay/cross-${CTARGET}/ghc
    #
    # # Building ghc crosscompiler:
    emerge -1 cross-${CTARGET}/ghc
    #
    powerpc64-unknown-linux-gnu-ghc --info | grep Target
    # ,("Target platform","powerpc64-unknown-linux")

Cross-building GHC on Gentoo
============================

Cross-building **ghc** on **${CTARGET}**:

.. code-block:: bash

    # # convenience variables:
    CTARGET=powerpc64-unknown-linux-gnu
    #
    # # Installing a target toolchain: gcc, glibc, binutils
    crossdev ${CTARGET}
    # # Installing ghc dependencies:
    emerge-${CTARGET} -1 libffi ncurses gmp
    #
    # # Cross-building ghc crosscompiler:
    emerge-${CTARGET} --buildpkg -1 dev-lang/ghc
    #
    # # Now built packages can be used on a target to install
    # # built ghc as: emerge --usepkg -1 dev-lang/ghc

Building a GHC crossompiler (generic)
=====================================

That's how you get a **powerpc64** crosscompiler in a fresh git checkout:

::

    $ ./configure --target=powerpc64-unknown-linux-gnu
    $ cat mk/build.mk
    HADDOCK_DOCS=NO
    BUILD_SPHINX_HTML=NO
    BUILD_SPHINX_PDF=NO
    # to speed things up
    BUILD_PROF_LIBS=NO
    $ make -j$(nproc)
    $ inplace/bin/ghc-stage1 --info | grep Target
    ,("Target platform","powerpc64-unknown-linux")

Simple!

Below are details that have only historical (or backporting) value.

How did we get there?
=====================

Cross-compiling support in **GHC** is not a new thing. **GHC** wiki has a
`detailed section <https://ghc.haskell.org/trac/ghc/wiki/Building/CrossCompiling>`_
on how to build a crosscompiler. That works quite good. You can
even target **ghc** at **m68k**: `porting example <https://trofi.github.io/posts/191-ghc-on-m68k.html>`_.

What did not work so well is the attempt to install the result! In some places
**GHC** build system tried to run **ghc-pkg** built for **${CBUILD}**,
in some places for **${CHOST}**.

I never really tried to install a crosscompiler before. I think mostly because
I was usually happy to make cross-compiler build at all: making **GHC** build
for a rare target usually required a patch or two.

But one day I've decided to give full install a run. Original motivation was a
bit unusual: I wanted to free space on my hard drive.

The build tree for **GHC** usually takes about 6-8GB. I had about 15 **GHC** 
source trees lying around. All in all it took about 10% of all space on my
hard drive. Fixing **make install** would allow me to install only final result
and get rid of all intermediate files.

I've decided to test **make install** code on **Gentoo**'s **dev-lang/ghc** package
as a proper package.

As a result a bunch of minor cleanups happened:

- `fixed NCG/llvm presence for target <https://git.haskell.org/ghc.git/commitdiff/cb18447c75e7673d5f57056fbdaa370d11e4c05e>`_
- `marked aarch64 as NCG/llvm target <https://git.haskell.org/ghc.git/commitdiff/911055689eca26c7c2713e251646fa35359acba3>`_
- `fixed ${CTARGET}-prefixing for hp2ps <https://git.haskell.org/ghc.git/commitdiff/1e58efb16f76b52c059d5e5d6c4c5d91c2abaad2>`_
- `fixed ${CTARGET}-prefixing for noncanonical targets <https://git.haskell.org/ghc.git/commitdiff/844704b4883e1d603a5048ddc6cbad737ba8d9e8>`_
- `dropped ${CTARGET}-prefixing for stage2 installs (crossbuilds) <https://git.haskell.org/ghc.git/commitdiff/f2685df3b10e13f142736f28835e9064334bc143>`_
- `added ${CTARGET}-prefixing for ghci <https://git.haskell.org/ghc.git/commitdiff/732b3dbbff194eb8650c75afd79d892801afa0dc>`_
- `fixed stage2 install to run only ${CBUILD} tools <https://git.haskell.org/ghc.git/commitdiff/54895c90440cb81f18657537b91f2aa35bd54173>`_
- `fixed all stage2 binaries to run on ${CHOST}, not ${CBUILD} <https://git.haskell.org/ghc.git/commitdiff/ff84d052850b637b03bbb98cf05202e44886257d>`_

What works?
===========

It allowed me to test various targets. Namely:

======================================= ===== ========== =======
Target                                  Bits  Endianness Codegen
======================================= ===== ========== =======
cross-aarch64-unknown-linux-gnu/ghc     64    LE         LLVM
cross-alpha-unknown-linux-gnu/ghc       64    LE         UNREG
cross-armv7a-unknown-linux-gnueabi/ghc  32    LE         LLVM
cross-hppa-unknown-linux-gnu/ghc        32    BE         UNREG
cross-m68k-unknown-linux-gnu/ghc        32    BE         UNREG
cross-mips64-unknown-linux-gnu/ghc      32/64 BE         UNREG
cross-powerpc64-unknown-linux-gnu/ghc   64    BE         NCG
cross-powerpc64le-unknown-linux-gnu/ghc 64    LE         NCG
cross-s390x-unknown-linux-gnu/ghc       64    BE         UNREG
cross-sparc-unknown-linux-gnu/ghc       32    BE         UNREG
cross-sparc64-unknown-linux-gnu/ghc     64    BE         UNREG
======================================= ===== ========== =======

I am running all of this on **x86_64** (64-bit LE platform)

Quite a list! With help of qemu we can even test whether cross-compiler
produces something that works:

::

    $ cat hi.hs 
    main = print "hello!"
    $ powerpc64le-unknown-linux-gnu-ghc hi.hs -o hi.ppc64le
    [1 of 1] Compiling Main             ( hi.hs, hi.o )
    Linking hi.ppc64le ...
    $ file hi.ppc64le 
    hi.ppc64le: ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), dynamically linked, interpreter /lib64/ld64.so.2, for GNU/Linux 3.2.0, not stripped
    $ qemu-ppc64le -L /usr/powerpc64le-unknown-linux-gnu/ ./hi.ppc64le 
    "hello!"

Many qemu targets are slightly buggy and usually are very easy to fix!

A few recent examples:

- epoll syscall is not wired properly on **qemu-alpha**: `patch <https://www.mail-archive.com/qemu-devel@nongnu.org/msg442471.html>`_
- CPU initialization code on **qemu-s390x**
- thread creation fails on **qemu-sparc32plus** due to simple **mmap()** emulation bug
- **tcg** on **qemu-sparc64** crashes at runtime in **static_code_gen_buffer()**

Tweaking qemu is fun :)

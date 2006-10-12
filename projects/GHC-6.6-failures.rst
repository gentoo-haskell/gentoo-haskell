=============================
Packages failing with GHC 6.6
=============================

:Authors: Lennart Kolmodin <kolmodin@gentoo.org>,
          Duncan Coutts <dcoutts@gentoo.org>,
          Gentoo Haskell Herd <haskell@gentoo.org>
:Updated: 2006-10-12

Failed packages
===============

These are packages currently in portage cvs. Those are the ones we care
about when it comes to this round of ghc-6.6 compatabilty testing.

So make sure you're not using the overlay when you're testing these packages.
For example use:
PORTDIR_OVERLAY="" emerge -pv dev-haskell/foo

Only the first error message is reported, as it is all I can see without
actually fixing anything :)

Packages We've used if not anything else mentioned:

* GHC 6.6
* haddock-0.8
* cabal-1.1.6

Note that we're listing all the versions for each package, however it's
only necessary to test the latest version with ghc-6.6. We can make previous
versions just block on gh-6.6.

Of course if we can't patch the latest version to work with ghc-6.6 then we
can just make it block on ghc-6.6 too *cough* wxhaskell *cough*.


dev-haskell/buddha-1.2
----------------------
blocked by >=ghc-6.4.


dev-haskell/buddha-1.2-r1
-------------------------

dcoutts messed up the patch, but that's now fixed in cvs.

missing dep on dev-haskell/haskell-src, other than that it builds fine.


dev-haskell/alex-2.0.1
----------------------
builds fine


dev-haskell/c2hs-0.13.4
-----------------------

dev-haskell/c2hs-0.14.5
-----------------------
builds fine


dev-haskell/cabal-1.1.3-r1
--------------------------
blocked by >=ghc-6.6.

dev-haskell/cabal-1.1.4
-----------------------
blocked by >=ghc-6.6.

This will be ok as we'll have cabal-1.1.6 in the tree shortly.


dev-haskell/cpphs-1.1
---------------------

dev-haskell/cpphs-1.2
---------------------
builds fine


dev-haskell/drift-2.1.2
-----------------------

dev-haskell/drift-2.2.0
-----------------------
builds fine


dev-haskell/frown-0.6.1-r1
--------------------------
builds fine


dev-haskell/gtk2hs-0.9.10
-------------------------

dev-haskell/gtk2hs-0.9.9
------------------------

dev-haskell/gtk2hs-0.9.10-r1
----------------------------

fails with:

::

  tools/c2hs/base/general/Binary.hs:59:7:
      Could not find module `Data.FiniteMap':
        Use -v to see a list of the files searched for.
  make[1]: *** Deleting file `tools/c2hs/c2hsLocal.deps'
  /usr/bin/ghc +RTS -RTS -c glib/System/Glib.hs -o glib/System/Glib.o -O -fffi -ignore-package glib -iglib -package-name glib '-#include<glib-object.h>' -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include

  glib/System/Glib.hs:12:0:
      Failed to load interface for `System.Glib.UTFString':
        Use -v to see a list of the files searched for.


dev-haskell/haddock-0.7
-----------------------

dev-haskell/haddock-0.8
-----------------------
builds fine


dev-haskell/happy-1.15
----------------------
builds fine


dev-haskell/harp-0.2
--------------------

builds fine


dev-haskell/haskell-src-exts-0.2
--------------------------------
builds fine.


dev-haskell/haxml-1.12
----------------------
blocked by >=ghc-6.6.


dev-haskell/haxml-1.13-r1
-------------------------
blocked by >=ghc-6.6.


dev-haskell/haxml-1.13.2
------------------------
builds fine


dev-haskell/hdbc-1.0.0
----------------------
needs mtl but builds fine


dev-haskell/hdbc-odbc-1.0.0.0
-----------------------------
needs mtl, fails with:

::

  dist/build/tmp/Database/HDBC/ODBC/Connection.hs:"Database/HDBC/ODBC/Connection.hsc": 77:43: Parse error


dev-haskell/hdbc-postgresql-1.0.0.0
-----------------------------------
needs mtl, builds fine.


dev-haskell/hdbc-sqlite-1.0.0.0
-------------------------------
needs mtl, builds fine without doc, haddock fails with:

::

  dist/build/tmp/Database/HDBC/Sqlite3/Statement.hs:"Database/HDBC/Sqlite3/Statement.hsc": 46:15: parse error in doc string: [haddock: EOF token


dev-haskell/hdoc-0.8.3
----------------------
builds fine


dev-haskell/hmake-3.10
----------------------
blocked by >=ghc-6.6.


dev-haskell/hmake-3.11
----------------------
builds fine (version 3.11)


dev-haskell/hs-plugins-0.9.10-r1
--------------------------------
fails with:

::

  System/Plugins/LoadTypes.hs:31:0:
      Bad interface file: /var/tmp/portage/hs-plugins-0.9.10-r1/work/hs-plugins-0.9.10/src/hi/Language/Hi/Parser.hi
          Something is amiss; requested module  hi-0.9.10:Language.Hi.Parser differs from name found in the interface file hi:Language.Hi.Parser


dev-haskell/hs-plugins-0.9.6
----------------------------
blocked by >=ghc-6.4.


dev-haskell/hs-plugins-0.9.8
----------------------------
blocked by >=ghc-6.4.


dev-haskell/hs-plugins-1.0_rc0
------------------------------
builds fine.


dev-haskell/hsql-1.7
--------------------
builds fine.


dev-haskell/hsql-mysql-1.7
--------------------------
builds fine.

dev-haskell/hsql-odbc-1.7
-------------------------
builds fine.


dev-haskell/hsql-postgresql-1.7
-------------------------------
builds fine.


dev-haskell/hsql-sqlite-1.7
---------------------------
builds fine.


dev-haskell/hsshellscript-2.2.2
-------------------------------
blocked by >=ghc-6.4.


dev-haskell/hsshellscript-2.3.0
-------------------------------
blocked by >=ghc-6.4.


dev-haskell/hsshellscript-2.6.0
-------------------------------
works.


dev-haskell/hsshellscript-2.6.3
-------------------------------
fails, needs package "lang".


dev-haskell/http-2006.7.7
-------------------------
works.

missing dep on:
* dev-haskell/network
* dev-haskell/mtl

other than that it builds fine


dev-haskell/hxt-4.02
--------------------
blocked by >=ghc-6.4.


dev-haskell/hxt-4.02-r1
-----------------------
blocked by >=ghc-6.4.


dev-haskell/hxt-5.00
--------------------
blocked by >=ghc-6.4.


dev-haskell/hxt-6.0
-------------------

missing dep on:
* dev-haskell/network 
* dev-haskell/hunit

but otherwise builds fine


dev-haskell/lhs2tex-1.10_pre
----------------------------
blocked by >=ghc-6.6.


dev-haskell/lhs2tex-1.11
------------------------
blocked by >=ghc-6.6.

This should be solved by a new lhs2tex-1.12 release.


dev-haskell/missingh-0.14.4
---------------------------

missing dep on:
* dev-haskell/network
* dev-haskell/mtl
* dev-haskell/haskell-src
* dev-haskell/hunit

fails with:

::

  MissingH/Str.hs:47:7:
      Could not find module `Text.Regex':
        it is a member of package regex-compat-0.71, which is hidden


in other words, it's missing a dep on the regex-compat package
though this only exists as of ghc-6.6 so will need conditional patching.
*sigh*.


dev-haskell/uuagc-0.9.1
-----------------------
builds fine


dev-haskell/uulib-0.9.2
-----------------------
I stand corrected, it works.


dev-haskell/wash-2.0.6
----------------------
blocked by >=ghc-6.4.


dev-haskell/wash-2.3.1
----------------------
blocked by >=ghc-6.4.


dev-haskell/wash-2.5.6
----------------------
fails with:

::

  M   -package text WASHOut.hs WASHData.hs WASHUtil.hs WASHParser.hs WASHClean.hs WASHFlags.hs WASHExpression.hs WASHGenerator.hs WASHMain.hs 
  make[3]: M: command not found

dev-haskell/wxhaskell-0.8-r1
----------------------------
blocked by >=ghc-6.4.

dev-haskell/wxhaskell-0.9
-------------------------
blocked by >=ghc-6.4.

dev-haskell/wxhaskell-0.9.4
---------------------------

::

  wx/src/Graphics/UI/WX/Types.hs:94:0:
     Bad interface file: out/wx/imports/Graphics/UI/WXCore/Types.hi
         Something is amiss; requested module  wx:Graphics.UI.WXCore.Types differs from name found in the interface file wxcore:Graphics.UI.WXCore.Types


This is a hard one to fix.


.. vim: tw=76 ts=2 :

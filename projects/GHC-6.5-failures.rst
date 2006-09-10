======================================
Packages failing with GHC 6.5.20060906
======================================

:Authors: Lennart Kolmodin <kolmodin@gentoo.org>,
          Gentoo Haskell Herd <haskell@gentoo.org>
:Updated: 2006-09-10

Failed libs
===========

Only the first error message is reported, as it is all I can see without
actually fixing anything :)

Libs I've used if not anything else mentioned:

* haddock-0.8\_rc1
* cabal-1.1.5.9.2

Some haddock docs might have failed, but since cabal didn't kill the setup
if haddock barkes in 1.1.5.9.2, it has gone by unnoticed by me...

dev-haskell/buddha-buddha-1.2
-----------------------------

::

  ghc-6.5.20060906: unknown package: text

dev-haskell/c2hs-0.14.5
-----------------------

::

  c2hs/c/CLexer.x:78:34: Module `Data.Set' does not export `mkSet'
  c2hs/c/CLexer.x:78:41: Module `Data.Set' does not export `addToSet'
  c2hs/c/CLexer.x:78:51: Module `Data.Set' does not export `elementOf'
 
dev-haskell/happy-1.15
----------------------

::

  LALR.lhs:626:34: Not in scope: `bounds'

dev-haskell/haskell-src-exts-0.2
--------------------------------

::

  Language/Haskell/Hsx/Lexer.hs:245:41:
   Ambiguous occurrence `isSymbol'
   It could refer to either `isSymbol', defined at Language/Haskell/Hsx/Lexer.hs:212:0
   or `isSymbol', imported from Data.Char
   at Language/Haskell/Hsx/Lexer.hs:26:0-15

 (repeaded 4 more times)

dev-haskell/haxml-1.16
----------------------

::

  src/Text/XML/HaXml/Escape.hs:57:7:
    Could not find module `Data.FiniteMap'

dev-haskell/hmake-3.11
----------------------

::

  ghc-6.5.20060906: unknown package: lang

dev-haskell/hsshellscript-2.6.3
-------------------------------

::

  ghc-6.5.20060906: unknown package: lang

dev-haskell/lhs2tex-1.11
------------------------

::

  /var/tmp/portage/lhs2tex-1.11/work/lhs2tex-1.11/Setup.hs:11:7:
      Could not find module `Distribution.Compat.FilePath':
            it is hidden (in package Cabal-1.1.5.9.2)

dev-haskell/missingh-0.14.4
---------------------------

::

  MissingH/Str.hs:47:7:
      Could not find module `Text.Regex'

dev-haskell/uulib-0.9.2
-----------------------

::

  src/UU/Parsing/StateParser.hs:5:0:
      Illegal instance declaration for `InputState (inp, state) s p'
          (the Coverage Condition fails for one of the functional dependencies)
      In the instance declaration for `InputState (inp, state) s p'

dev-haskell/wxhaskell-0.9.4
---------------------------

::

  wx/src/Graphics/UI/WX/Types.hs:94:0:
      Bad interface file: out/wx/imports/Graphics/UI/WXCore/Types.hi
          Something is amiss; requested module
              wx:Graphics.UI.WXCore.Types differs from name found in the
              interface file wxcore:Graphics.UI.WXCore.Types

dev-haskell/hsgnutls-0.2.2
--------------------------

::

  /var/tmp/portage/hsgnutls-0.2.2/work/hsgnutls-0.2.2/Setup.lhs:16:39:
      Couldn't match expected type `LocalBuildInfo -> IO ExitCode'
             against inferred type `IO ExitCode'
      Probable cause: `testGnutlsVersion' is applied to too many arguments
      In the `postConf' field of a record
      In the expression:
          defaultUserHooks
              {postConf = testGnutlsVersion,
              postBuild = fixBuild,
              postClean = deleteExtras}

dev-haskell/newbinary-0.1-r1
----------------------------

::

  cannot satisfy dependency lang-any


dev-haskell/shellac-0.3
-----------------------

::

  src/System/Console/Shell/Commands.hs:171:0:
      Illegal instance declaration for `CommandFunction (Int -> r) st'
          (the Coverage Condition fails for one of the functional dependencies)
      In the instance declaration for `CommandFunction (Int -> r) st'

  (and 7 more like it)

dev-haskell/opengl-2.1
----------------------

Package successfully installed, but haddock chokes on a file::

  dist/build/tmp/Graphics/Rendering/OpenGL/GL/BeginEnd.hs:"dist/build/tmp/Graphics/Rendering/OpenGL/GL/BeginEnd.hs": 129:16: Parse error

Cabal patch `Fri Sep  8 19:36:15 CEST 2006  Duncan Coutts <remove.this.part.duncan.coutts@worc.ox.ac.uk>` takes care of cabal not dying.

Problem with opengl remains though.

Untested libs
=============

* dev-haskell/hdbc (needs deps I didn't want to install just yet)
* dev-haskell/hdbc-*
* hs-plugins (needs haskell-src-exts)
* dev-haskell/hsql
* dev-haskell/hsql-* (same as hdbc)
* uuagc (need uulib)
* cabal-get (obsolete)
* fps (included in base)
* gh (requires uuagc/uulib)
* hackage-client (requires haxml)
* haxr (requires haxml)
* shellac-readline (requires shellac)
* trhsx (requires haskell-src-exts)
* hsp-darcs (requires haskell-src-exts)
* hspr-darcs (requires haskell-src-exts)
* requires (requires trhsx)

.. vim: tw=76 ts=2 :

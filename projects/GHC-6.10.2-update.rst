==========
GHC 6.10.2
==========

:Authors: Lennart Kolmodin <kolmodin@gentoo.org>,
          Gentoo Haskell Herd <haskell@gentoo.org>

News with GHC 6.10.2
====================

We've in Gentoo Linux has made some changes to the vanilla GHC application:

* Use ``readline`` instead of ``libedit``

Packages currently in portage, masked. To try them, unmask the following
packages;

* ``dev-lang/ghc``
* ``dev-haskell/haddock``
* ``dev-haskell/parallel``

Due to the recent changes with the base packages, exception handling etc, we
need to make extra sure that the packages in portage still works with GHC 6.10.
We should look for, and test, the latest ``~arch`` version, as well as the
latest stable version for each package.

::

  alex-2.1.0                                    amd64         ~ia64   ppc   ppc64   sparc   x86
  alex-2.2                                     ~amd64         ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  alex-2.3.1                                   ~amd64         ~ia64  ~ppc          ~sparc  ~x86
  alut-1.0                                     ~amd64                                      ~x86
  alut-2.0.1                                    amd64                              ~sparc   x86
  alut-2.0                                     ~amd64                                      ~x86
  alut-2.1.0.0                                  amd64                               sparc   x86
  arrows-0.2.1                         ~alpha   amd64         ~ia64   ppc           sparc   x86
  arrows-0.2                           ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  binary-0.4.1                                 ~amd64                              ~sparc  ~x86
  binary-0.4.2                                 ~amd64                              ~sparc  ~x86
  bzlib-0.4.0.1                                ~amd64                              ~sparc  ~x86
  c2hs-0.14.5                                   amd64         ~ia64   ppc   ppc64   sparc   x86
  c2hs-0.15.1                                  ~amd64         ~ia64  ~ppc          ~sparc  ~x86
  cabal-1.1.3-r1                       ~alpha   amd64  ~hppa  ~ia64   ppc   ppc64   sparc   x86
  cabal-1.1.4                          ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  cabal-1.1.6.1                        ~alpha   amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  cabal-1.1.6.2                        ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  cabal-1.2.3.0                         alpha   amd64   hppa   ia64   ppc  ~ppc64   sparc   x86
  cabal-1.6.0.1                        ~alpha  ~amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  cabal-1.6.0.2                        ~alpha  ~amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  cabal-1.6.0.3                        ~alpha  ~amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  cabal-install-0.6.2                          ~amd64                              ~sparc  ~x86
  cgi-2006.9.6                         ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  cgi-3001.1.1                         ~alpha   amd64                ~ppc           sparc   x86
  cgi-3001.1.5.1                                amd64                               sparc   x86
  cgi-3001.1.7.1                       ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  cpphs-1.1                                    ~amd64         ~ia64        ~ppc64  ~sparc  ~x86
  cpphs-1.2                                     amd64         ~ia64   ppc   ppc64   sparc   x86
  cpphs-1.3                                    ~amd64         ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  cpphs-1.5                                    ~amd64         ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  drift-2.1.2                                   amd64                 ppc   ppc64   sparc   x86
  drift-2.2.0                                   amd64                 ppc   ppc64   sparc   x86
  editline-0.2.1.0                             ~amd64                                      ~x86
  fgl-5.2                              ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  fgl-5.3                              ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  fgl-5.4.1.1                          ~alpha   amd64  ~hppa  ~ia64  ~ppc           sparc   x86
  fgl-5.4.1                            ~alpha   amd64         ~ia64   ppc           sparc   x86
  fgl-5.4.2.2                          ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  filepath-1.0                                  amd64   hppa  ~ia64   ppc           sparc   x86
  filepath-1.1.0.0                     ~alpha   amd64  ~hppa  ~ia64                 sparc   x86
  frown-0.6.1-r1                                amd64                 ppc   ppc64   sparc   x86
  ghc-paths-0.1.0.5                            ~amd64                                      ~x86
  glut-2.0                                     ~amd64                                      ~x86
  glut-2.0-r1                                  ~amd64                                      ~x86
  glut-2.1.1.1                                  amd64                               sparc   x86
  glut-2.1.1.2                                 ~amd64                              ~sparc  ~x86
  glut-2.1.1                                    amd64                              ~sparc   x86
  gtk2hs-0.9.11                                ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  gtk2hs-0.9.12.1                               amd64                ~ppc  ~ppc64  ~sparc   x86
  gtk2hs-0.9.12                                ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  haddock-0.8                           alpha   amd64   hppa   ia64   ppc   ppc64   sparc   x86
  haddock-0.9                          ~alpha  ~amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  haddock-2.4.2                                ~amd64                                      ~x86
  happy-1.15                                    amd64         ~ia64   ppc   ppc64   sparc   x86
  happy-1.16                                    amd64         ~ia64   ppc   ppc64   sparc   x86
  happy-1.17                                    amd64  ~hppa  ~ia64  ~ppc  ~ppc64   sparc   x86
  happy-1.18.2                                 ~amd64  ~hppa  ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  harp-0.2                                     ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  haskell-src-1.0.1.1                           amd64  ~hppa  ~ia64  ~ppc           sparc   x86
  haskell-src-1.0.1.3                          ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  haskell-src-1.0.1                    ~alpha   amd64         ~ia64   ppc           sparc   x86
  haskell-src-1.0                      ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  haskell-src-1.0-r1                   ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  haskell-src-exts-0.2                         ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  haxml-1.12                                   ~amd64                ~ppc          ~sparc  ~x86
  haxml-1.13.2                                  amd64         ~ia64   ppc   ppc64   sparc   x86
  haxml-1.13.3                                 ~amd64         ~ia64  ~ppc  ~ppc64  ~sparc  ~x86
  haxml-1.13-r1                                 amd64         ~ia64   ppc   ppc64   sparc   x86
  hdbc-1.0.0                                   ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-1.0.1                                   ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-1.1.3                                   ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-odbc-1.0.0.0                            ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-odbc-1.0.1.1                            ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-odbc-1.1.3.0                            ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-postgresql-1.0.0.0                      ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-postgresql-1.0.1.0                      ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-postgresql-1.1.3.0                      ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-sqlite-1.0.0.0                          ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-sqlite-1.0.1.0                          ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdbc-sqlite-1.1.3.0                          ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hdoc-0.8.3                                    amd64                 ppc   ppc64   sparc   x86
  hmake-3.10                                   ~amd64                      ~ppc64  ~sparc  ~x86
  hmake-3.11                                   ~amd64                ~ppc   ppc64   sparc   x86
  hmake-3.13                                   ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hscolour-1.12                                ~amd64                              ~sparc  ~x86
  hscolour-1.8                                 ~amd64                              ~sparc  ~x86
  hslogger-1.0.1                               ~amd64                                      ~x86
  hslogger-1.0.2                               ~amd64                              ~sparc  ~x86
  hsql-1.7                                     ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hsql-mysql-1.7                               ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hsql-odbc-1.7                                ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hsql-postgresql-1.7                          ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hsql-sqlite-1.7                              ~amd64                ~ppc  ~ppc64  ~sparc  ~x86
  hsshellscript-2.2.2                                                                      ~x86
  hsshellscript-2.3.0                                                                       x86
  hsshellscript-2.6.0                          ~amd64                ~ppc                  ~x86
  hsshellscript-2.6.3                          ~amd64                ~ppc                  ~x86
  hsshellscript-2.7.0                          ~amd64                ~ppc          ~sparc  ~x86
  html-1.0.1.1                          alpha   amd64   hppa   ia64  ~ppc           sparc   x86
  html-1.0.1.2                         ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  html-1.0.1                           ~alpha   amd64         ~ia64   ppc           sparc   x86
  html-1.0                             ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  html-1.0-r1                          ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  http-2006.7.7                                ~amd64                              ~sparc  ~x86
  http-3001.0.0                                ~amd64  ~hppa                       ~sparc  ~x86
  http-4000.0.5                                ~amd64  ~hppa                       ~sparc  ~x86
  hunit-1.1.1                          ~alpha   amd64         ~ia64   ppc           sparc   x86
  hunit-1.1                            ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  hunit-1.1-r1                         ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  hunit-1.2.0.0                        ~alpha   amd64   hppa  ~ia64  ~ppc           sparc   x86
  hunit-1.2.0.3                        ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  hxt-4.02-r1                                                                              ~x86
  hxt-4.02                                                                                 ~x86
  hxt-5.00                                                                                 ~x86
  hxt-6.0                                      ~amd64                                      ~x86
  hxt-7.2                                      ~amd64                                      ~x86
  hxt-7.3                                      ~amd64                              ~sparc  ~x86
  iconv-0.4                                    ~amd64                              ~sparc  ~x86
  lhs2tex-1.10_pre                             ~amd64                       ppc64  ~sparc   x86
  lhs2tex-1.11                                  amd64                       ppc64   sparc   x86
  missingh-0.14.4                              ~amd64                                      ~x86
  missingh-0.16.0                              ~amd64                                      ~x86
  missingh-0.18.6                              ~amd64                              ~sparc  ~x86
  mtl-1.0.1                            ~alpha   amd64         ~ia64   ppc           sparc   x86
  mtl-1.0                              ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  mtl-1.0-r1                           ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  mtl-1.1.0.0                           alpha   amd64   hppa   ia64  ~ppc           sparc   x86
  mtl-1.1.0.2                          ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  network-1.0                          ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  network-2.0.1                        ~alpha   amd64         ~ia64   ppc           sparc   x86
  network-2.0                          ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  network-2.1.0.0                               amd64   hppa  ~ia64                 sparc   x86
  network-2.2.0.0                              ~amd64  ~hppa  ~ia64                ~sparc  ~x86
  network-2.2.0.1                              ~amd64  ~hppa  ~ia64                ~sparc  ~x86
  network-2.2.1                        ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  openal-1.2                                   ~amd64                                      ~x86
  openal-1.3.1.1                                amd64                               sparc   x86
  openal-1.3.1                                  amd64                              ~sparc   x86
  openal-1.3                                   ~amd64                                      ~x86
  opengl-2.0                                   ~amd64                                      ~x86
  opengl-2.1                                   ~amd64                                      ~x86
  opengl-2.2.1.1                                amd64                               sparc   x86
  opengl-2.2.1                                  amd64                              ~sparc   x86
  parallel-1.0.0.0                              amd64  ~hppa                        sparc   x86
  parallel-1.1.0.1                             ~amd64                                      ~x86
  parsec-2.0                                   ~amd64                ~ppc          ~sparc  ~x86
  parsec-2.1.0.0                        alpha   amd64   hppa   ia64   ppc           sparc   x86
  parsec-2.1.0.1                       ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  quickcheck-1.0.1                     ~alpha   amd64         ~ia64   ppc           sparc   x86
  quickcheck-1.0                       ~alpha   amd64   hppa  ~ia64   ppc   ppc64   sparc   x86
  quickcheck-1.0-r1                    ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  quickcheck-1.1.0.0                    alpha   amd64   hppa   ia64  ~ppc           sparc   x86
  quickcheck-1.2.0.0                   ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  regex-base-0.71                              ~amd64         ~ia64                        ~x86
  regex-base-0.72.0.1                  ~alpha   amd64         ~ia64  ~ppc           sparc   x86
  regex-base-0.72.0.2                  ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  regex-base-0.72                               amd64   hppa  ~ia64   ppc           sparc   x86
  regex-base-0.93.1                     alpha  ~amd64   hppa   ia64                ~sparc  ~x86
  regex-compat-0.71.0.1                ~alpha   amd64         ~ia64  ~ppc           sparc   x86
  regex-compat-0.71                             amd64   hppa  ~ia64   ppc           sparc   x86
  regex-compat-0.91                     alpha  ~amd64   hppa   ia64                ~sparc  ~x86
  regex-posix-0.71                              amd64   hppa  ~ia64   ppc           sparc   x86
  regex-posix-0.72.0.2                 ~alpha   amd64         ~ia64  ~ppc           sparc   x86
  regex-posix-0.72.0.3                 ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  regex-posix-0.93.1                    alpha  ~amd64   hppa   ia64                ~sparc  ~x86
  stm-2.1.1.0                                   amd64  ~hppa                        sparc   x86
  stm-2.1.1.2                                  ~amd64  ~hppa                       ~sparc  ~x86
  time-1.0                             ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  time-1.1.1                           ~alpha   amd64         ~ia64   ppc           sparc   x86
  time-1.1.2.0                         ~alpha   amd64  ~hppa  ~ia64  ~ppc           sparc   x86
  time-1.1.2.4                         ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  uuagc-0.9.1                                   amd64                 ppc   ppc64   sparc   x86
  uuagc-0.9.5                                  ~amd64                ~ppc          ~sparc  ~x86
  uulib-0.9.2                                   amd64                 ppc   ppc64   sparc   x86
  wash-2.12                                    ~amd64                              ~sparc  ~x86
  wxhaskell-0.9.4                              ~amd64                ~ppc          ~sparc  ~x86
  x11-1.1                                      ~amd64                                      ~x86
  x11-1.2.1                                    ~amd64                                      ~x86
  x11-1.2.2                                    ~amd64                                      ~x86
  x11-1.2                                      ~amd64                                      ~x86
  x11-1.4.0                                    ~amd64                              ~sparc  ~x86
  x11-1.4.1                                    ~amd64                              ~sparc  ~x86
  x11-1.4.2                                    ~amd64  ~hppa                       ~sparc  ~x86
  xhtml-2006.9.13                      ~alpha  ~amd64                ~ppc          ~sparc  ~x86
  xhtml-3000.0.2.1                     ~alpha   amd64   hppa  ~ia64  ~ppc           sparc   x86
  xhtml-3000.0.2                       ~alpha   amd64         ~ia64   ppc           sparc   x86
  xhtml-3000.2.0.1                     ~alpha  ~amd64  ~hppa  ~ia64  ~ppc          ~sparc  ~x86
  zlib-0.4.0.1                                 ~amd64                              ~sparc  ~x86
  zlib-0.5.0.0                                 ~amd64                              ~sparc  ~x86

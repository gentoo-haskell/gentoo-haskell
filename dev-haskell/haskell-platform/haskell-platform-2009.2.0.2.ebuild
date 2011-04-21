# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

DESCRIPTION="The Haskell Platform"
HOMEPAGE="http://haskell.org/haskellwiki/Haskell_Platform"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# for slot dependencies
EAPI=1

# use gnome style of meta packages;
# minimum version, open range

# for the packages parsec and quickcheck we depend on SLOT="0" and SLOT="1" to
# not get too recent versions (quickcheck-2 and parsec-3 which behaves
# significantly different)

# for the regex-packages we don't want the 0.9x series, and there is currently
# no way in portage to specify a from-to range interval. thus, we depend on the
# exact version.

DEPEND="~dev-lang/ghc-6.10.4
		>=dev-haskell/cabal-1.6.0.3
		>=dev-haskell/cgi-3001.1.7.1
		>=dev-haskell/editline-0.2.1.0
		>=dev-haskell/fgl-5.4.2.2
		>=dev-haskell/glut-2.1.1.2
		>=dev-haskell/haskell-src-1.0.1.3
		>=dev-haskell/html-1.0.1.2
		>=dev-haskell/http-4000.0.6
		>=dev-haskell/hunit-1.2.0.3
		>=dev-haskell/mtl-1.1.0.2
		>=dev-haskell/network-2.2.1.4
		>=dev-haskell/opengl-2.2.1.1
		>=dev-haskell/parallel-1.1.0.1
		>=dev-haskell/parsec-2.1.0.1:0
		>=dev-haskell/quickcheck-1.2.0.0:1
		>=dev-haskell/stm-2.1.1.2
		>=dev-haskell/time-1.1.2.4
		>=dev-haskell/xhtml-3000.2.0.1
		>=dev-haskell/zlib-0.5.0.0

		>=dev-haskell/alex-2.3.1
		>=dev-haskell/happy-1.18.4
		>=dev-haskell/cabal-install-0.6.2
		>=dev-haskell/haddock-2.4.2

		~dev-haskell/regex-base-0.72.0.2
		~dev-haskell/regex-compat-0.71.0.1
		~dev-haskell/regex-posix-0.72.0.3"

RDEPEND="${DEPEND}"

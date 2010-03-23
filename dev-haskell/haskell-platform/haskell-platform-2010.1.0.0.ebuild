# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

DESCRIPTION="The Haskell Platform"
HOMEPAGE="http://haskell.org/haskellwiki/Haskell_Platform"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EAPI=1

DEPEND="~dev-lang/ghc-6.12.1
		~dev-haskell/cabal-1.8.0.2
		~dev-haskell/cgi-3001.1.7.2
		~dev-haskell/deepseq-1.1.0.0
		~dev-haskell/fgl-5.4.2.2
		~dev-haskell/glut-2.1.2.1
		~dev-haskell/haskell-src-1.0.1.3
		~dev-haskell/html-1.0.1.2
		~dev-haskell/http-4000.0.9
		~dev-haskell/hunit-1.2.2.1
		~dev-haskell/mtl-1.1.0.2
		~dev-haskell/network-2.2.1.7
		~dev-haskell/opengl-2.2.3.0
		~dev-haskell/parallel-2.2.0.1
		~dev-haskell/parsec-2.1.0.1
		~dev-haskell/quickcheck-2.1.0.3
		~dev-haskell/regex-base-0.93.1
		~dev-haskell/regex-compat-0.92
		~dev-haskell/regex-posix-0.94.1
		~dev-haskell/stm-2.1.1.2
		~dev-haskell/xhtml-3000.2.0.1
		~dev-haskell/zlib-0.5.2.0
		~dev-haskell/cabal-install-0.8.0
		~dev-haskell/alex-2.3.2
		~dev-haskell/happy-1.18.4
		~dev-haskell/haddock-2.6.0"

RDEPEND="${DEPEND}"

# .cabal file has this version commented out, but it isn't in the tarball
# ~dev-haskell/haddock-2.7.2

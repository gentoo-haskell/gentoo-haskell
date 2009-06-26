# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile"
inherit haskell-cabal

DESCRIPTION="The Haskell-Scriptable Editor"
HOMEPAGE="http://haskell.org/haskellwiki/Yi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		=dev-haskell/binary-0.5*
		=dev-haskell/bytestring-0.9.1*
		=dev-haskell/cabal-1.6*
		=dev-haskell/data-accessor-0.2*
		=dev-haskell/data-accessor-monads-fd-0.2*
		=dev-haskell/data-accessor-template-0.2*
		=dev-haskell/derive-0.1*
		=dev-haskell/diff-0.1*
		=dev-haskell/filepath-1.1*
		dev-haskell/fingertree
		>=dev-haskell/gtk2hs-0.9.13
		dev-haskell/monads-fd
		>=dev-haskell/pointedlist-0.3.1
		>=dev-haskell/puremd5-0.2.3
		>=dev-haskell/quickcheck-2
		=dev-haskell/regex-base-0.93*
		=dev-haskell/regex-tdfa-1.0*
		=dev-haskell/rosezipper-0.1*
		=dev-haskell/split-0.1*
		=dev-haskell/time-1.1*
		=dev-haskell/transformers-0.1*
		dev-haskell/uniplate
		=dev-haskell/unix-compat-0.1*
		>=dev-haskell/utf8-string-0.3.1
		>=dev-haskell/vty-3.1.8
		>=dev-haskell/alex-2.0.1
        =dev-haskell/ghc-paths-0.1*"

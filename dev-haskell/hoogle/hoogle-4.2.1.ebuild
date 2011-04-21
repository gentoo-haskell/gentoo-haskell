# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Haskell API Search"
HOMEPAGE="http://www.haskell.org/hoogle/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/binary
		<dev-haskell/blaze-builder-0.4
		=dev-haskell/cabal-1.10*
		=dev-haskell/cmdargs-0.6*
		=dev-haskell/enumerator-0.4*
		<dev-haskell/haskell-src-exts-1.11
		>=dev-haskell/parsec-2.1
		dev-haskell/safe
		=dev-haskell/tagsoup-0.12*
		dev-haskell/time
		=dev-haskell/transformers-0.2*
		=dev-haskell/uniplate-1.6*
		=dev-haskell/wai-0.4*
		=dev-haskell/warp-0.4*
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}/${P}-warp.patch")

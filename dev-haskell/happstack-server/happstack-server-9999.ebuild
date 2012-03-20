# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit darcs haskell-cabal

DESCRIPTION="Web related tools and services."
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="<dev-haskell/blaze-html-0.5
		dev-haskell/dlist
		=dev-haskell/happstack-data-9999
		=dev-haskell/happstack-util-9999
		>=dev-haskell/hslogger-1.0.2
		dev-haskell/html
		dev-haskell/maybet
		<dev-haskell/mtl-2.1
		dev-haskell/murmur-hash
		=dev-haskell/network-2.3*
		<dev-haskell/parsec-4
		dev-haskell/psqueue
		>=dev-haskell/sendfile-0.7.1
		<dev-haskell/text-0.12
		dev-haskell/time
		>=dev-haskell/utf8-string-0.3.4
		dev-haskell/vector
		dev-haskell/xhtml
		dev-haskell/zlib
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

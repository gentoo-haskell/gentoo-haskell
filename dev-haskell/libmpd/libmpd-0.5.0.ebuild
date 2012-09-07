# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="An MPD client library."
HOMEPAGE="http://github.com/joachifm/libmpd-haskell"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		<dev-haskell/mtl-2.1
		>=dev-haskell/network-2.1
		<dev-haskell/utf8-string-0.4"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

PATCHES=("${FILESDIR}/${PN}-0.5.0-ghc-7.patch")

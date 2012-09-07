# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="An MPD client library."
HOMEPAGE="http://github.com/joachifm/libmpd-haskell"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		=dev-haskell/mtl-1.1*
		>=dev-haskell/network-2.1
		<dev-haskell/utf8-string-0.4"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

src_prepare() {
	# Loosen dependency on network
	sed -i -e "s/network >= 2.1 && < 2.3,/network >= 2.1,/" \
		"${S}/${PN}.cabal" \
		|| die "Could not loosen deps on network"
}

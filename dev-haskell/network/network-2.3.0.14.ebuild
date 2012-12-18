# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal autotools

DESCRIPTION="Low-level networking interface"
HOMEPAGE="http://github.com/haskell/network"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-haskell/parsec[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( <dev-haskell/hunit-1.3[profile?]
			<dev-haskell/test-framework-0.7[profile?]
			<dev-haskell/test-framework-hunit-0.3[profile?]
		)"

src_prepare() {
	epatch "${FILESDIR}/network-2.2.0.0-eat-configure-opts.patch"
	epatch "${FILESDIR}/network-2.3.0.14-ghc-7.5.patch"
	eautoreconf
}

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal autotools

DESCRIPTION="Low-level networking interface"
HOMEPAGE="http://github.com/haskell/network"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-haskell/parsec
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( <dev-haskell/hunit-1.3
			<dev-haskell/test-framework-0.5
			<dev-haskell/test-framework-hunit-0.3
		)"

src_prepare() {
	epatch "${FILESDIR}/network-2.2.0.0-eat-configure-opts.patch"
	eautoreconf
}

src_configure() {
	cabal_src_configure $(use_enable test tests)
}

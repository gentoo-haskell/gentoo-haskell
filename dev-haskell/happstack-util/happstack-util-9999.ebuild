# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Web framework"
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hslogger-1.0.2
		<dev-haskell/mtl-2.1
		>=dev-haskell/network-2.2
		<dev-haskell/parsec-4
		dev-haskell/time
		dev-haskell/unix-compat
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	pushd "${WORKDIR}"
	mv ${P} happstack-parent
	ln -s happstack-parent/${PN} ${P}
	popd
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="lib profile haddock hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Happstack for Web Application Interface."
HOMEPAGE="http://happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/maybet
		dev-haskell/mtl
		dev-haskell/utf8-string
		=dev-haskell/wai-0.2*
		dev-haskell/wai-extra
		dev-haskell/web-encodings
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

src_prepare() {
	sed -e 's@mtl >= 1.1 && < 1.2@mtl >= 1.1 \&\& < 2.1@' \
		-i "${S}/${PN}.cabal"
	sed -e 's@fmap lft@liftM lft@' \
		-i "${S}/Happstack/Server/Monads.hs"
}

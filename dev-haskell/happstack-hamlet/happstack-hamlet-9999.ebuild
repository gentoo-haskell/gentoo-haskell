# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit darcs haskell-cabal

DESCRIPTION="Support for Hamlet HTML templates in Happstack"
HOMEPAGE="http://www.happstack.com/"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"
EDARCS_GET_CMD="get --partial"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-haskell/hamlet-0.10[profile?]
		<dev-haskell/hamlet-1.2[profile?]
		=dev-haskell/happstack-server-9999[profile?]
		dev-haskell/text[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@hamlet >= 0.10 && <1.1@hamlet >= 0.10 \&\& <1.2@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

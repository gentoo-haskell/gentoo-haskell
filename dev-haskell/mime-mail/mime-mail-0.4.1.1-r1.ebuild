# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Compose MIME email messages."
HOMEPAGE="http://github.com/snoyberg/mime-mail"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/base64-bytestring-0.1[profile?]
		<dev-haskell/base64-bytestring-1.1[profile?]
		>=dev-haskell/blaze-builder-0.2.1[profile?]
		<dev-haskell/blaze-builder-0.4[profile?]
		=dev-haskell/random-1.0*[profile?]
		>=dev-haskell/text-0.7[profile?]
		<dev-haskell/text-0.12[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	sed -e 's@filepath            >= 1.2@filepath            >= 1.1@' \
		-e 's@base64-bytestring   >= 0.1        && < 0.2@base64-bytestring   >= 0.1        \&\& < 1.1@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.2

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="yesod recaptcha2"
HOMEPAGE="https://github.com/ncaq/yesod-recaptcha2#readme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/classy-prelude:=[profile?]
	dev-haskell/http-conduit:=[profile?]
	dev-haskell/yesod-auth:=[profile?]
	dev-haskell/yesod-core:=[profile?]
	dev-haskell/yesod-form:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

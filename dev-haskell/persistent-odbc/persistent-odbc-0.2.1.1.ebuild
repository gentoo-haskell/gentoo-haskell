# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Backend for the persistent library using ODBC"
HOMEPAGE="https://github.com/gbwey/persistent-odbc"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="debug tester"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/conduit:=[profile?]
	dev-haskell/convertible:=[profile?]
	>=dev-haskell/hdbc-2.1.0:=[profile?]
	>=dev-haskell/hdbc-odbc-2.6.0.0:=[profile?]
	dev-haskell/monad-logger:=[profile?]
	>=dev-haskell/persistent-2.6.0:=[profile?]
	>=dev-haskell/persistent-template-2.6.0:=[profile?]
	dev-haskell/resourcet:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-8.8.1:=
	tester? ( dev-haskell/blaze-html:=[profile?]
			>=dev-haskell/esqueleto-2.1:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.0.0.0
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag debug debug) \
		$(cabal_flag tester tester)
}

CABAL_CHDEPS=(
	'persistent-template >= 2.6.0 && < 2.8.3' 'persistent-template >= 2.6.0'
	'persistent    >= 2.6.0 && < 2.11' 'persistent    >= 2.6.0'
)

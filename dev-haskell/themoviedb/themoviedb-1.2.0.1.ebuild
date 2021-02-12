# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell API bindings for http://themoviedb.org"
HOMEPAGE="https://github.com/pjones/themoviedb"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="maintainer"

RDEPEND=">=dev-haskell/aeson-1.0:=[profile?] <dev-haskell/aeson-1.6:=[profile?]
	>=dev-haskell/http-client-0.4.31:=[profile?] <dev-haskell/http-client-0.8:=[profile?]
	>=dev-haskell/http-client-tls-0.2.2:=[profile?] <dev-haskell/http-client-tls-0.4:=[profile?]
	>=dev-haskell/http-types-0.8:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/relude-0.6:=[profile?] <dev-haskell/relude-0.8:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.10.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2
	test? ( >=dev-haskell/tasty-0.10 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-hunit-0.9 <dev-haskell/tasty-hunit-0.11 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag maintainer maintainer)
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_HACKAGE_REVISION="1"
inherit haskell-cabal

DESCRIPTION="A Haskell implementation of MessagePack"
HOMEPAGE="https://msgpack.org/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal
		-> ${P}-rev${CABAL_HACKAGE_REVISION}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/data-binary-ieee754-0.4.4:=[profile?] <dev-haskell/data-binary-ieee754-0.5:=[profile?]
	>=dev-haskell/hashable-1.1.2.4:=[profile?]
	>=dev-haskell/unordered-containers-0.2.5:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/vector-0.10.11:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/async-2.2 <dev-haskell/async-2.3
		>=dev-haskell/quickcheck-2.12
		>=dev-haskell/tasty-1.2
		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.11 )
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${P}-rev${CABAL_HACKAGE_REVISION}.cabal" "${S}/${PN}.cabal" || die

	# Convert to unix line endings
	dos2unix "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default

	cabal_chdeps \
		'QuickCheck         == 2.12.*' 'QuickCheck >=2.12' \
		'tasty              == 1.2.*' 'tasty >=1.2' \
		'base                 >= 4.7     && < 4.15' 'base >=4.7' \
		'hashable             >= 1.1.2.4 && < 1.4' 'hashable >=1.1.2.4'
}

# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Fine-grained library for constructing and manipulating lattices"
HOMEPAGE="https://github.com/phadej/lattices/"
HACKAGE_REV="2"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${HACKAGE_REV}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/base-compat-0.10.5:=[profile?] <dev-haskell/base-compat-0.13:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/integer-logarithms-1.0.3:=[profile?] <dev-haskell/integer-logarithms-1.1:=[profile?]
	>=dev-haskell/onetuple-0.3:=[profile?] <dev-haskell/onetuple-0.4:=[profile?]
	>=dev-haskell/quickcheck-2.12.6.1:2=[profile?] <dev-haskell/quickcheck-2.15:2=[profile?]
	>=dev-haskell/semigroupoids-5.3.2:=[profile?] <dev-haskell/semigroupoids-5.4:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/universe-base-1.1:=[profile?] <dev-haskell/universe-base-1.2:=[profile?]
	>=dev-haskell/universe-reverse-instances-1.1:=[profile?] <dev-haskell/universe-reverse-instances-1.2:=[profile?]
	>=dev-haskell/unordered-containers-0.2.8.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
	test? ( >=dev-haskell/quickcheck-instances-0.3.19 <dev-haskell/quickcheck-instances-0.4
		>=dev-haskell/tasty-1.2.1 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-quickcheck-0.10 <dev-haskell/tasty-quickcheck-0.11 )
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die

	# Convert to unix line endings
	dos2unix "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default
}

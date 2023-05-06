# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Generic basis for random number generators"
HOMEPAGE="https://github.com/mokus0/random-fu"
HACKAGE_REV="1"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${HACKAGE_REV}.cabal -> ${PF}.cabal"

LICENSE="public-domain"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/flexible-defaults-0.0.0.2:=[profile?]
	dev-haskell/mersenne-random-pure64:=[profile?]
	dev-haskell/mwc-random:=[profile?]
	dev-haskell/primitive:=[profile?]
	>=dev-haskell/random-1.2.0:=[profile?] <dev-haskell/random-1.3:=[profile?]
	>=dev-haskell/stateref-0.3:=[profile?] <dev-haskell/stateref-0.4:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/th-extras:=[profile?]
	>=dev-lang/ghc-8.4.3:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
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

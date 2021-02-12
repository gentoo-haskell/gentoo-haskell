# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.5.9999
#hackport: flags: -bundled-binary-generic

CABAL_FEATURES="lib profile" # Drop test-suite: circular depends
CABAL_FEATURES+=" nocabaldep" # in case installed Cabal is broken
inherit haskell-cabal

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="https://www.haskell.org/cabal/"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
# Only unmask amd64 and x86
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT=test # circular dependencies

RDEPEND=">=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/parsec-3.1.13.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/text-1.2.3.0:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}"

CABAL_CORE_LIB_GHC_PV="PM:8.4.2_rc1 PM:8.4.2 PM:8.4.3 PM:8.4.4"

PATCHES=("${FILESDIR}"/${PN}-2.0.0.2-no-bootstrap.patch)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	cabal_chdeps \
		'tasty >= 1.0 && < 1.1' 'tasty >= 1.0' \
		'base-compat >=0.9.3 && <0.10' 'base-compat >=0.9.3' \
		'base-compat          >=0.9.3    && <0.10' 'base-compat          >=0.9.3' \
		'base-orphans         >=0.6      && <0.7' 'base-orphans         >=0.6'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-bundled-binary-generic
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="hspecVariant"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Spec for testing properties for variant types"
HOMEPAGE="https://github.com/sanjorgek/hspecVariant"
SRC_URI="https://hackage.haskell.org/package/${MY_P}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hspec-2.2:=[profile?] <dev-haskell/hspec-3:=[profile?]
	~dev-haskell/quickcheckvariant-0.2.0.0:=[profile?]
	>=dev-lang/ghc-7.6.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.16.0
"

S="${WORKDIR}/${MY_P}"

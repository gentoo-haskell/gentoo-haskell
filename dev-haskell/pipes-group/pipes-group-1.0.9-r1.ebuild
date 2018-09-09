# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.4.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Group streams into substreams"
HOMEPAGE="http://hackage.haskell.org/package/pipes-group"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT=test # Control.Monad.Trans.Free is in free and transformers-free

RDEPEND=">=dev-haskell/free-3.2:=[profile?]
	>=dev-haskell/pipes-4.0:=[profile?] <dev-haskell/pipes-4.4:=[profile?]
	>=dev-haskell/pipes-parse-3.0.0:=[profile?] <dev-haskell/pipes-parse-3.1:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/doctest-0.9.12
		<dev-haskell/lens-family-core-1.3 )
"

src_prepare() {
	default

	cabal_chdeps \
		'free         >= 3.2     && < 5.1' 'free         >= 3.2' \
		'doctest          >= 0.9.12 && < 0.13' 'doctest          >= 0.9.12'
}

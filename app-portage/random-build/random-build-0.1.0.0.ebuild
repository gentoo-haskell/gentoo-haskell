# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999
#hackport: flags: +pedantic

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Build random packages in a Gentoo repository and evaluate the success rate"
HOMEPAGE="https://github.com/gentoo-haskell/random-build"
SRC_URI="https://github.com/gentoo-haskell/random-build/releases/download/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/conduit-1.3.6:=[profile?] <dev-haskell/conduit-1.4:=[profile?]
	>=dev-haskell/conduit-extra-1.3.7:=[profile?] <dev-haskell/conduit-extra-1.4:=[profile?]
	>=dev-haskell/effectful-2.5.1.0:=[profile?] <dev-haskell/effectful-2.6:=[profile?]
	>=dev-haskell/effectful-core-2.5.0:=[profile?] <dev-haskell/effectful-core-2.6:=[profile?]
	>=dev-haskell/flatparse-0.5.2.1:=[profile?] <dev-haskell/flatparse-0.6:=[profile?]
	>=dev-haskell/list-shuffle-1.0.0.0:=[profile?] <dev-haskell/list-shuffle-1.1:=[profile?]
	>=dev-haskell/monad-time-effectful-1.0.0.0:=[profile?] <dev-haskell/monad-time-effectful-1.1:=[profile?]
	>=dev-haskell/optparse-applicative-0.18.1.0:=[profile?] <dev-haskell/optparse-applicative-0.19:=[profile?]
	>=dev-haskell/portage-hs-0.1.0.0:=[profile?] <dev-haskell/portage-hs-0.2:=[profile?]
	>=dev-haskell/prettyprinter-1.7.0:=[profile?] <dev-haskell/prettyprinter-1.8:=[profile?]
	>=dev-haskell/prettyprinter-ansi-terminal-1.1.3:=[profile?] <dev-haskell/prettyprinter-ansi-terminal-1.2:=[profile?]
	>=dev-haskell/text-1.2.5.0:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-haskell/time-compat-1.9.8:=[profile?] <dev-haskell/time-compat-1.10:=[profile?]
	>=dev-haskell/unordered-containers-0.2.20:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-lang/ghc-9.0.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=pedantic
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999
#hackport: flags: _:underline

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Library and utility for processing cabal's plan.json file"
HOMEPAGE="https://hackage.haskell.org/package/cabal-plan"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="license-report underline"

RDEPEND=">=dev-haskell/text-1.2.2:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.6.2:=
	>=dev-haskell/aeson-1.4.0.0:=[profile?]
	>=dev-haskell/base16-bytestring-0.1.1:=[profile?] <dev-haskell/base16-bytestring-1.1:=[profile?]
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag underline _) \
		$(cabal_flag license-report license-report)
}

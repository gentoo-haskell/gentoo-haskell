# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.5.9999
#hackport: flags: -buildtests

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit eutils haskell-cabal

DESCRIPTION="Encapsulate multiple web encoding in a single package. (deprecated)"
HOMEPAGE="https://hackage.haskell.org/package/web-encodings"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/failure-0.0.0:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	dev-haskell/time-locale-compat:=[profile?]
	>=dev-lang/ghc-6.12.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8.0.2
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-time-1.5.patch

	cabal_chdeps \
		'bytestring >= 0.9.1.4 && < 0.10' 'bytestring >= 0.9.1.4' \
		'directory >= 1 && < 1.2' 'directory >= 1' \
		'failure >= 0.0.0 && < 0.2' 'failure >= 0.0.0' \
		'text >= 0.11 && < 0.12' 'text >= 0.11'
}

src_configure() {
	haskell-cabal_src_configure \
		--flag=-buildtests
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A Testing Framework for Haskell"
HOMEPAGE="http://hspec.github.io/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/ansi-terminal-0.5:=[profile?]
	dev-haskell/call-stack:=[profile?]
	>=dev-haskell/clock-0.7.1:=[profile?]
	>=dev-haskell/hspec-expectations-0.8.2:=[profile?] <dev-haskell/hspec-expectations-0.8.3:=[profile?]
	>=dev-haskell/hunit-1.6:=[profile?] <dev-haskell/hunit-1.7:=[profile?]
	>=dev-haskell/quickcheck-2.13.1:2=[profile?]
	>=dev-haskell/quickcheck-io-0.2.0:=[profile?]
	dev-haskell/random:=[profile?]
	dev-haskell/setenv:=[profile?]
	>=dev-haskell/stm-2.2:=[profile?]
	dev-haskell/tf-random:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/hspec-meta-2.3.2
		>=dev-haskell/quickcheck-2.14
		>=dev-haskell/silently-1.2.4
		dev-haskell/temporary )
"

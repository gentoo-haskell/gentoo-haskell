# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

# ebuild generated by hackport 0.2.19

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Haskell code prettifier"
HOMEPAGE="https://github.com/jaspervdj/stylish-haskell"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/aeson-0.6*[profile?]
		>=dev-haskell/cmdargs-0.9[profile?]
		<dev-haskell/cmdargs-0.11[profile?]
		=dev-haskell/haskell-src-exts-1.13*[profile?]
		>=dev-haskell/mtl-2.0[profile?]
		<dev-haskell/mtl-2.2[profile?]
		=dev-haskell/strict-0.3*[profile?]
		=dev-haskell/syb-0.3*[profile?]
		>=dev-haskell/yaml-0.7[profile?]
		<dev-haskell/yaml-0.9[profile?]
		>=dev-lang/ghc-7.0.1"
DEPEND="${RDEPEND}
		test? ( =dev-haskell/hunit-1.2*
			>=dev-haskell/test-framework-0.4
			<dev-haskell/test-framework-0.7
			=dev-haskell/test-framework-hunit-0.2*
		)
		>=dev-haskell/cabal-1.8"

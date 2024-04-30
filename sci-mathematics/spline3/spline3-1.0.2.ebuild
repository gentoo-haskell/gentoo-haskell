# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="test-suite"
inherit haskell-cabal

DESCRIPTION="parallel implementation of the Sorokina/Zeilfelder spline scheme"
HOMEPAGE="https://michael.orlitzky.com/code/spline3.xhtml"
SRC_URI="https://michael.orlitzky.com/code/releases/${P}.tar.gz"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT=test # Ambiguous module name ‘Data.Vector’

RDEPEND=">=dev-haskell/cmdargs-0.10:=
	>=dev-haskell/missingh-1:=
	>=dev-haskell/repa-3:=
	>=dev-haskell/repa-algorithms-3:=
	>=dev-haskell/repa-io-3:=
	>=dev-haskell/tasty-0.8:=
	>=dev-haskell/tasty-hunit-0.8:=
	>=dev-haskell/tasty-quickcheck-0.8.1:=
	>=dev-haskell/vector-0.10:=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/doctest-0.9 )
"

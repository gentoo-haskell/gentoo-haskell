# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="The Glasgow Haskell Compiler API (ghc package)"
HOMEPAGE="http://www.haskell.org/ghc"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cabal"

# The easiest way to fetch libraries 'ghc' package depends on
# is to fire ghci and run ':set -package ghc' there.
RDEPEND="
	~dev-haskell/binary-0.7.1.0:=
	cabal? ( ~dev-haskell/cabal-1.18.1.3:= )
	=dev-lang/ghc-${PVR}:=
	~dev-haskell/transformers-0.3.0.0:=
"
DEPEND="${RDEPEND}"

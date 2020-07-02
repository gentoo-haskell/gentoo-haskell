# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The Glasgow Haskell Compiler API (ghc package)"
HOMEPAGE="http://www.haskell.org/ghc"

LICENSE="BSD"
SLOT="0/${PV}"
#keep in sync with ghc-8.8.3
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# The easiest way to fetch libraries 'ghc' package depends on
# is to fire ghci and run ':set -package ghc' there.
RDEPEND="
	~dev-haskell/binary-0.8.7.0:=
	=dev-lang/ghc-${PVR}:=
	~dev-haskell/transformers-0.5.6.2:=
"
DEPEND="${RDEPEND}"

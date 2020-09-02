# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The Glasgow Haskell Compiler API (ghc package)"
HOMEPAGE="https://www.haskell.org/ghc"

LICENSE="BSD"
SLOT="0/${PV}"
#keep in sync with ghc-8.4.4
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# The easiest way to fetch libraries 'ghc' package depends on
# is to fire ghci and run ':set -package ghc' there.
RDEPEND="
	~dev-haskell/binary-0.8.5.1:=
	=dev-lang/ghc-${PVR}:=
	~dev-haskell/transformers-0.5.5.0:=
"
DEPEND="${RDEPEND}"

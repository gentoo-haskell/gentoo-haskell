# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The Glasgow Haskell Compiler API (ghc package)"
HOMEPAGE="http://www.haskell.org/ghc"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE=""

# The easiest way to fetch libraries 'ghc' package depends on
# is to fire ghci and run ':set -package ghc' there.
RDEPEND="
	~dev-haskell/binary-0.7.3.0:=
	=dev-lang/ghc-${PVR}:=
	~dev-haskell/hoopl-3.10.0.2:=
	~dev-haskell/hpc-0.6.0.2:=
	~dev-haskell/transformers-0.4.2.0:=
"
DEPEND="${RDEPEND}"

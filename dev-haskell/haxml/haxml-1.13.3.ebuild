# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib bin profile haddock"
inherit haskell-cabal versionator

MY_PN="HaXml"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilities for manipulating XML documents"
HOMEPAGE="http://www.cs.york.ac.uk/fp/HaXml/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="$(get_version_component_range 1-2 ${PV})"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE=""

DEPEND=">=dev-lang/ghc-6.2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	# Don't warn so much, and don't compile with -O2
	sed -i 's/GHC-Options: -Wall -O2/GHC-Options: -O/' "${S}/HaXml.cabal"

	# Unless ghc 6.8, remove the new packages
	if ! version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e 's/, pretty, containers//' \
			"${S}/HaXml.cabal"
	fi
}

src_install() {
	cabal_src_install

	if use doc; then
		dohtml -r docs/*
		dodoc docs/icfp99.dvi docs/icfp99.ps.gz
	fi
}

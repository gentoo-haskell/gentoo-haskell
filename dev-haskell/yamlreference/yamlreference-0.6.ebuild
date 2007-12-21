# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib bin"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

MY_PN="YamlReference"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="YAML reference implementation"
HOMEPAGE="http://www.ben-kiki.org/oren/YamlReference"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		>=dev-haskell/hunit-1.1
		>=dev-haskell/regex-compat-0.71
		>=dev-haskell/dlist-0.2
		dev-haskell/bytestring"

S="${WORKDIR}/${MY_P}"

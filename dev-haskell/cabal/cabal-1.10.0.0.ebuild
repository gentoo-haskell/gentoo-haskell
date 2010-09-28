# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bootstrap lib"
inherit haskell-cabal eutils

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc"

# Cabal.cabal only depends on base>=1&&<5 and filepath>=1&&<1.2
# filepath has been a ghc core library since ghc 6.6.1, so let's use that as the
# lowest possible ghc version
DEPEND="=dev-lang/ghc-7*"
RDEPEND="${DEPEND}
		dev-util/pkgconfig"
# cabal uses dev-util/pkgconfig using runtime to resolve C dependencies, so
# repoman's RDEPEND.suspect QA does not apply here

S="${WORKDIR}/${MY_P}"

CABAL_CORE_LIB_GHC_PV="7.0.0.20100924"

src_unpack() {
	mkdir "${S}"
}

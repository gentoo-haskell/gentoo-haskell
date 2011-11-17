# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit haskell-cabal

MY_PN="LDAP"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Haskell binding for C LDAP API"
HOMEPAGE="http://software.complete.org/ldap-haskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.1
		>=net-nds/openldap-2.4.19"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# remove -O2
	sed -i -e "s/GHC-Options: -O2//" "${S}/LDAP.cabal"
}

src_install() {
	cabal_src_install
	dodoc COPYING COPYRIGHT
}

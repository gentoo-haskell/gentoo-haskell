# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
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

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/cabal
		>=net-nds/openldap-2.1.30"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"

	# remove -O2
	sed -i -e "s/GHC-Options: -O2//" "${S}/LDAP.cabal"

	# Fix for openldap < 2.4
	if ! version_is_at_least "2.4" $(best_version net-nds/openldap); then
		sed -i -e "s/LDAP_X_PROXY_AUTHZ_FAILURE/LDAP_PROXY_AUTHZ_FAILURE/" \
			"${S}/LDAP/Data.hsc"
	fi
}

src_install() {
	cabal_src_install
	dodoc COPYING COPYRIGHT
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Haskell binding for C LDAP API"
HOMEPAGE="http://software.complete.org/ldap-haskell"
SRC_URI="http://software.complete.org/ldap-haskell/static/download_area/${PV}/ldap-haskell_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4.2
		>=net-nds/openldap-2.1.30"

S="${WORKDIR}/ldap-haskell"

src_unpack() {
	unpack "${A}"

	# change -O2 to -O
	sed -i -e "s/GHC-Options: -O2/GHC-Options: -O/" "${S}/LDAP.cabal"

	# Aarg! Fix version number
	sed -i -e "s/Version: 0.5.2/Version: 0.6.1/" "${S}/LDAP.cabal"

	# For some reason ldap_unbind is deprecated in openldap
	echo "CC-Options: -DLDAP_DEPRECATED" >> "${S}/LDAP.cabal"
}

src_install() {
	cabal_src_install
	dodoc COPYING COPYRIGHT
}

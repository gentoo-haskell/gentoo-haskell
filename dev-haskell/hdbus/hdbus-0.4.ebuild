# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit base haskell-cabal

MY_PN="DBus"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Haskell bindings for D-Bus"
HOMEPAGE="http://hackage.haskell.org/package/DBus"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
	sys-apps/dbus"
DEPEND=">=dev-haskell/cabal-1.6
	sys-apps/sed
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${PN}-0.4-ghc-7.4.patch")

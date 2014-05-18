# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal

MY_PN="qtHaskell"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="qtHaskell is a set of Haskell bindings for the Qt Widget Library from Nokia."
HOMEPAGE="http://qthaskell.berlios.de/"
SRC_URI="mirror://berlios/qthaskell/${MY_P}.1.tar.bz2"

# The license is uncertain, the web site says its currently GPL, while as the LICENSE file looks like BSD.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/qthaskellc
		dev-haskell/opengl:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

PATCHES=("${FILESDIR}/${PN}-1.1.4-cabal-remove-haskell98.patch"
	"${FILESDIR}/${PN}-1.1.4-qtc-classes-base-monad-to-control-monad.patch"
	"${FILESDIR}/${PN}-1.1.4-qtc-core-attributes-fix-type-error.patch"
	"${FILESDIR}/${PN}-1.1.4-ghc-7.6.patch"
	"${FILESDIR}/${PN}-1.1.4-ghc-7.8.patch"
)

src_prepare() {
	base_src_prepare
	# takes A Lot of RAM
	[[ $(ghc-version) == 7.8.* ]] && replace-hcflags -O[2-9] -O1
}

src_install() {
	cabal_src_install
	dodoc INSTALL README
	dohtml doc/apiGuide/* doc/primer/* doc/userGuide/*
}

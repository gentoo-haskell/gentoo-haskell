# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="DBus"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Haskell bindings for D-Bus"
HOMEPAGE="http://hackage.haskell.org/package/DBus"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
	>=sys-apps/dbus-0.60"
DEPEND=">=dev-haskell/cabal-1.6
	>=sys-apps/sed-4
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:defaultMain:defaultMainWithHooks autoconfUserHooks:' Setup.hs \
		|| die 'Sed failed.'
	sed -i 's:PatternSignatures:ScopedTypeVariables:' DBus/Message.hsc \
		|| die 'Sed failed.'
	sed -i 's:Control.Exception:Control.OldException:' DBus/Internal.hsc \
		|| die 'Sed failed.'
}

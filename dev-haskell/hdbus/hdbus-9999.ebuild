# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit base darcs haskell-cabal autotools

DESCRIPTION="Haskell bindings for D-Bus"
HOMEPAGE="http://neugierig.org/software/hdbus/"
LICENSE="BSD"
SLOT="${PV}"

KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	sys-apps/dbus"

EDARCS_REPOSITORY="http://neugierig.org/software/darcs/hdbus"
EDARCS_GET_CMD="get --partial"

S="${S}/module"

src_compile() {
	eautoreconf
	haskell-cabal_src_compile
}

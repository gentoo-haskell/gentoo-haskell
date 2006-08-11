# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="haddock lib"
inherit base darcs haskell-cabal

DESCRIPTION="Haskell bindings for D-Bus"
HOMEPAGE="http://neugierig.org/software/hdbus/"
LICENSE="BSD"
SLOT="${PV}"

KEYWORDS="~x86"	#if possible try testing with "~amd64", "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.4
		>=sys-apps/dbus-0.60"

EDARCS_REPOSITORY="http://neugierig.org/software/darcs/hdbus"
EDARCS_GET_CMD="get --partial"

S="${S}/module"

src_unpack() {
	darcs_src_unpack
	echo "extra-libraries: dbus-1" >> ${S}/DBus.cabal
}

src_compile() {
	# cabal hasn't got pkg-config support yet so we need to process
	# the *.hsc files manually before cabal gets into the game
	for f in $( find -name \*.hsc ); do
		/usr/bin/hsc2hs `pkg-config --cflags dbus-1` \
			-o "${S}/${f%.hsc}."{hs,hsc}
	done
	haskell-cabal_src_compile
}

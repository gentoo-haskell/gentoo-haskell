# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# THIS IS AN UNOFFICIAL EBUILD. PLEASE CONTACT kosmikus@gentoo.org DIRECTLY
# IF YOU EXPERIENCE PROBLEMS. PLEASE DO NOT WRITE TO GENTOO-MAILING LISTS
# AND DON'T FILE ANY BUGS IN BUGZILLA ABOUT THIS BUILD.

EAPI=5

EDARCS_REPOSITORY="http://kosmikus.org/repos/exi/"

CABAL_FEATURES="bin lib haddock"

inherit darcs haskell-cabal

DESCRIPTION="A reimplementation of the emerge layer of Portage written in Haskell"
HOMEPAGE="http://kosmikus.org/exi/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=sys-apps/portage-2.1_pre4
	>=dev-lang/ghc-6.4.1:=
	dev-haskell/fgl:="

DEPEND="${REPEND}"

src_prepare() {
	CABAL_FILE=portage.cabal cabal_chdeps \
		'base,' 'base, containers, directory, process,'
}

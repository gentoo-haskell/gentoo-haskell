# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# THIS IS AN UNOFFICIAL EBUILD. PLEASE CONTACT kosmikus@gentoo.org DIRECTLY
# IF YOU EXPERIENCE PROBLEMS. PLEASE DO NOT WRITE TO GENTOO-MAILING LISTS
# AND DON'T FILE ANY BUGS IN BUGZILLA ABOUT THIS BUILD.

EDARCS_REPOSITORY="http://haskell.org/~andres/repos/exi"
EDARCS_GET_CMD="get --partial"

CABAL_FEATURES="bin lib haddock"

inherit darcs haskell-cabal

DESCRIPTION="A reimplementation of the emerge layer of Portage written in Haskell"
HOMEPAGE="http://www.iai.uni-bonn.de/~loeh/exi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=sys-apps/portage-2.1_pre4"

DEPEND="${REPEND}
	>=dev-lang/ghc-6.4.1
	dev-haskell/fgl"


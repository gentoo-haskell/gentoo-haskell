# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin"
inherit darcs haskell-cabal #elisp

DESCRIPTION="Provides better support for editing Haskell by using GHC-Api. Currently only provides emacs support."
HOMEPAGE="http://shim.haskellco.de/"
EDARCS_REPOSITORY="http://shim.haskellco.de/shim/"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.6
	dev-haskell/cabal
	dev-haskell/filepath
	virtual/emacs
	app-emacs/haskell-mode"




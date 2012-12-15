# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xmonad-contrib/xmonad-contrib-0.9.2.ebuild,v 1.2 2012/09/12 16:12:15 qnikst Exp $

EAPI="3"

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal eutils

DESCRIPTION="Third party extensions for xmonad"
HOMEPAGE="http://xmonad.org/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft"

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/mtl
		>=dev-haskell/x11-1.5
		dev-haskell/utf8-string
		xft? ( >=dev-haskell/x11-xft-0.2 )
		~x11-wm/xmonad-${PV}"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.1"

src_configure() {
	cabal_src_configure --flags=-testing $(cabal_flag xft use_xft)
}

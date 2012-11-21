# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal git-2

DESCRIPTION="Leksah tool kit"
HOMEPAGE="http://www.leksah.org"
EGIT_REPO_URI="git://github.com/leksah/ltk.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-haskell/cabal-1.6.0[profile?]
		<dev-haskell/cabal-1.19[profile?]
		>=dev-haskell/glib-0.10.0[profile?]
		<dev-haskell/glib-0.13[profile?]
		>=dev-haskell/gtk-0.10.0[profile?]
		<dev-haskell/gtk-0.13[profile?]
		>=dev-haskell/mtl-1.1.0.2[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/parsec-2.1.0.1[profile?]
		<dev-haskell/parsec-3.2[profile?]
		>=dev-haskell/transformers-0.2.2.0[profile?]
		<dev-haskell/transformers-0.4[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

src_prepare() {
	if has_version "<dev-lang/ghc-7.0.1" && has_version ">=dev-haskell/cabal-1.10.0.0"; then
		# with ghc 6.12 leksah-server does not work with cabal-1.10, so use ghc-6.12 shipped one
		# since leksah-server uses cabal, haddock, and ltk, ltk must use ghc 6.12 cabal for ghc < 7.
		sed -e 's@build-depends: Cabal >=1.6.0 && <1.15@build-depends: Cabal >=1.6.0 \&\& <1.9@g' \
			-i "${S}/${PN}.cabal"
	fi
}

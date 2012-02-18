# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile"
inherit base haskell-cabal git-2

DESCRIPTION="Haskell IDE written in Haskell"
HOMEPAGE="http://www.leksah.org"
EGIT_REPO_URI="git://github.com/leksah/leksah.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="yi"

RDEPEND=">=dev-lang/ghc-6.12.1
		net-misc/wget
		yi? ( >=app-editors/yi-0.6.2.4 )"
DEPEND="${RDEPEND}
		=dev-haskell/binary-0.5*
		=dev-haskell/binary-shared-0.8*
		<dev-haskell/cabal-1.15
		<dev-haskell/deepseq-1.4
		=dev-haskell/glib-0.12*
		=dev-haskell/gtk-0.12*
		=dev-haskell/gtksourceview2-0.12*
		<dev-haskell/hslogger-1.2
		=app-editors/leksah-server-9999
		=dev-haskell/ltk-9999
		<dev-haskell/mtl-2.1
		<dev-haskell/network-3.0
		<dev-haskell/parsec-2.2
		>=dev-haskell/process-leksah-1.0.1.3
		=dev-haskell/regex-base-0.93*
		=dev-haskell/regex-tdfa-1.1*
		<dev-haskell/strict-0.4
		dev-haskell/time
		>=dev-haskell/utf8-string-0.3.1.1
		>=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.8"

CABAL_CONFIGURE_FLAGS="$(cabal_flag yi)"

src_prepare() {
	if has_version "<dev-lang/ghc-7.0.1" && has_version ">=dev-haskell/cabal-1.10.0.0"; then
		# with ghc 6.12 leksah does not work with cabal-1.10, so use ghc-6.12 shipped one
		sed -e 's@build-depends: Cabal >=1.6.0.1 && <1.11@build-depends: Cabal >=1.6.0.1 \&\& <1.9@' \
			-e 's@deepseq >=1.1 && <1.2@deepseq >=1.1 \&\& <1.3@' \
			-i "${S}/${PN}.cabal"
	fi
}

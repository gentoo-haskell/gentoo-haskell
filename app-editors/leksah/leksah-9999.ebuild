# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile"
inherit haskell-cabal git-2

DESCRIPTION="Haskell IDE written in Haskell"
HOMEPAGE="http://www.leksah.org"
EGIT_REPO_URI="git://github.com/leksah/leksah.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="dyre? ( yi )"
IUSE="dyre yi"

RDEPEND="=app-editors/leksah-server-9999[profile?]
		>=dev-haskell/binary-0.5.0.0[profile?]
		<dev-haskell/binary-0.6[profile?]
		=dev-haskell/binary-shared-0.8*[profile?]
		>=dev-haskell/cabal-1.6.0.1[profile?]
		<dev-haskell/cabal-1.15[profile?]
		>=dev-haskell/deepseq-1.1.0.0[profile?]
		<dev-haskell/deepseq-1.4[profile?]
		>=dev-haskell/enumerator-0.4.14[profile?]
		<dev-haskell/enumerator-0.5[profile?]
		>=dev-haskell/gio-0.12.2[profile?]
		<dev-haskell/gio-0.13[profile?]
		>=dev-haskell/glib-0.10[profile?]
		<dev-haskell/glib-0.13[profile?]
		>=dev-haskell/gtk-0.10[profile?]
		<dev-haskell/gtk-0.13[profile?]
		>=dev-haskell/gtksourceview2-0.10.0[profile?]
		<dev-haskell/gtksourceview2-0.13[profile?]
		>=dev-haskell/hslogger-1.0.7[profile?]
		<dev-haskell/hslogger-1.2[profile?]
		=dev-haskell/ltk-9999[profile?]
		>=dev-haskell/mtl-1.1.0.2[profile?]
		<dev-haskell/mtl-2.2[profile?]
		>=dev-haskell/network-2.2[profile?]
		<dev-haskell/network-3.0[profile?]
		>=dev-haskell/parsec-2.1.0.1[profile?]
		<dev-haskell/parsec-3.2[profile?]
		>=dev-haskell/quickcheck-2.4.2[profile?]
		<dev-haskell/quickcheck-2.5[profile?]
		=dev-haskell/regex-base-0.93*[profile?]
		=dev-haskell/regex-tdfa-1.1*[profile?]
		>=dev-haskell/strict-0.3.2[profile?]
		<dev-haskell/strict-0.4[profile?]
		>=dev-haskell/text-0.11.1.5[profile?]
		<dev-haskell/text-0.12[profile?]
		>=dev-haskell/time-0.1[profile?]
		<dev-haskell/time-1.5[profile?]
		>=dev-haskell/transformers-0.2.2.0[profile?]
		<dev-haskell/transformers-0.4[profile?]
		>=dev-haskell/utf8-string-0.3.1.1[profile?]
		<dev-haskell/utf8-string-0.4[profile?]
		>=dev-lang/ghc-6.10.1
		yi? ( >=app-editors/yi-0.6.2.4 )
		dev-haskell/cabal-install"
# dev-haskell/cabal is used at runtime to build edited package
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"

src_prepare() {
	if has_version "<dev-lang/ghc-7.0.1" && has_version ">=dev-haskell/cabal-1.10.0.0"; then
		# with ghc 6.12 does not work with cabal-1.10, so use ghc-6.12 shipped one
		sed -e 's@build-depends: Cabal >=1.6.0.1 && <1.15@build-depends: Cabal >=1.6.0.1 \&\& <1.9@g' \
			-i "${S}/${PN}.cabal"
	fi
	# workaround haddock 2.10.0 error: parse error on input `-- ^ source buffer view'
	sed -e 's@-- ^@--@g' \
		-i "${S}/src/IDE/SymbolNavigation.hs" \
		|| die "Could not remove haddock markup"
}

src_configure() {
	threaded_flag=""
	if $(ghc-getghc) --info | grep "Support SMP" | grep -q "YES"; then
		threaded_flag="--flags=threaded"
		einfo "$P will be built with threads support"
	else
		threaded_flag="--flags=-threaded"
		einfo "$P will be built without threads support"
	fi
	cabal_src_configure $threaded_flag \
		$(cabal_flag dyre) \
		$(cabal_flag yi)
}

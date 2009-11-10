# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal eutils

DESCRIPTION="The Haskell-Scriptable Editor"
HOMEPAGE="http://haskell.org/haskellwiki/Yi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome gtk vty"

DEPEND=">=dev-lang/ghc-6.10.1
		=dev-haskell/binary-0.5*
		=dev-haskell/cabal-1.6*
		=dev-haskell/data-accessor-0.2*
		=dev-haskell/data-accessor-monads-fd-0.2*
		=dev-haskell/data-accessor-template-0.2*
		=dev-haskell/derive-0.1*
		=dev-haskell/diff-0.1*
		>=dev-haskell/dlist-0.4.1
		=dev-haskell/filepath-1.1*
		<dev-haskell/fingertree-0.1
		=dev-haskell/ghc-paths-0.1*
		dev-haskell/monads-fd
		>=dev-haskell/pointedlist-0.3.1
		>=dev-haskell/puremd5-0.2.3
		=dev-haskell/regex-base-0.93*
		=dev-haskell/regex-tdfa-1.1*
		=dev-haskell/rosezipper-0.1*
		=dev-haskell/split-0.1*
		=dev-haskell/time-1.1*
		=dev-haskell/transformers-0.1*
		dev-haskell/uniplate
		=dev-haskell/unix-compat-0.1*
		>=dev-haskell/utf8-string-0.3.1
		<dev-haskell/alex-3
		gtk? ( dev-haskell/gtk2hs[gnome?] )
		vty? ( <dev-haskell/vty-4 )"

pkg_setup() {
	cabal_pkg_setup

	if ! (use gtk || use vty); then
		ewarn "${PN} requires either USE=gtk or USE=vty to build a user interface."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}/Yi"

	# Avoid duplicate instance with data-accessor-0.2.1
	epatch "${FILESDIR}/${P}-prelude_instance_category.patch"
}

src_compile() {
	CABAL_CONFIGURE_FLAGS="--flags=-testing"

	if use gtk; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=pango"
		if use gnome; then
			CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=gnome"
		else
			CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-gnome"
		fi
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-pango"
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-gnome"
	fi

	if use vty; then
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=vty"
	else
		CABAL_CONFIGURE_FLAGS="$CABAL_CONFIGURE_FLAGS --flags=-vty"
	fi

	cabal_src_compile
}

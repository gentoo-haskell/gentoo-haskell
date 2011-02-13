# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="2"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="The Haskell-Scriptable Editor"
HOMEPAGE="http://haskell.org/haskellwiki/Yi"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

# The home page is missing information, so I note some here:
# There are now multiple repos after the code.haskell.org outage, not sure which is the master.
# The Mercurial repo on Google code has the bug database:
# http://code.google.com/p/yi-editor/
# The github repo has recent activity:
# https://github.com/yi-editor/yi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome gtk vty"

# Using a hack for minimum Cabal version: you can't use <1.6 with 6.10 anyway,
# so just specify upper bound
RDEPEND=">=dev-lang/ghc-6.10.1
		=dev-haskell/binary-0.5*
		<dev-haskell/cabal-1.11
		<dev-haskell/cautious-file-0.2
		<dev-haskell/data-accessor-0.3
		=dev-haskell/data-accessor-monads-fd-0.2*
		<dev-haskell/data-accessor-template-0.2.2
		=dev-haskell/derive-2.4*
		=dev-haskell/diff-0.1*
		>=dev-haskell/dlist-0.4.1
		>=dev-haskell/dyre-0.7
		<dev-haskell/fingertree-0.1
		=dev-haskell/ghc-paths-0.1*
		>dev-haskell/hint-0.3.1
		dev-haskell/monads-fd
		<dev-haskell/pointedlist-0.4
		>=dev-haskell/puremd5-0.2.3
		=dev-haskell/regex-base-0.93*
		=dev-haskell/regex-tdfa-1.1*
		=dev-haskell/rosezipper-0.1*
		=dev-haskell/split-0.1*
		dev-haskell/time
		dev-haskell/uniplate
		<dev-haskell/unix-compat-0.3
		>=dev-haskell/utf8-string-0.3.1
		vty? ( =dev-haskell/vty-4* )
		gtk? ( =dev-haskell/glib-0.12*
			   =dev-haskell/gtk-0.12*
			   gnome? ( =dev-haskell/gconf-0.12* ) )"
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.6"

CABAL_CONFIGURE_FLAGS="$(cabal_flag gnome)
					   $(cabal_flag gtk)
					   $(cabal_flag vty)"

src_prepare() {
	cd "${S}"
	epatch "${FILESDIR}/${P}-bump-deps.patch" || die "Could not apply ${P}-bump-deps.patch"
	if has_version ">=dev-lang/ghc-7.0.1"; then
		# Adapted from upstream patch: http://code.google.com/p/yi-editor/issues/detail?id=324
		epatch "${FILESDIR}/${P}-ghc-7.patch" || die "Could not apply ${P}-ghc-7.patch"
	fi
}

src_configure() {
	cabal_src_configure \
		--flags=-testing \
		$(cabal_flag gtk pango) \
		$(cabal_flag gnome) \
		$(cabal_flag vty)

	if ! (use gtk || use vty); then
		ewarn "${PN} requires either USE=gtk or USE=vty to build a user interface."
	fi
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# ebuild generated by hackport 0.2.13

EAPI="4"

EGIT_REPO_URI="git://github.com/mvv/transformers-base.git"
EGIT_COMMIT="master"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal eutils git-2

DESCRIPTION="Lift control operations, like exception catching, through monad transformers"
HOMEPAGE="https://github.com/mvv/transformers-base"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="<dev-haskell/base-unicode-symbols-0.3
		=dev-haskell/base-4.3.1.0
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.9.2
		test? (
			>=dev-haskell/cabal-1.10
			<dev-haskell/test-framework-0.5
			<dev-haskell/test-framework-hunit-0.3
		)
		"

src_configure() {
	cabal_src_configure $(use_enable test tests) $(cabal_flag test)
}

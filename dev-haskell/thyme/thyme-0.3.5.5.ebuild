# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.4.4.9999
#hackport: flags: -werror,-hlint

CABAL_FEATURES="lib profile haddock hoogle hscolour" # Broken test-suite: need update against QuickCheck-2.11
inherit haskell-cabal

DESCRIPTION="A faster time library"
HOMEPAGE="https://github.com/liyang/thyme"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+bug-for-bug lens show-internal"

RESTRICT=test # optimization-dependent

RDEPEND=">=dev-haskell/aeson-0.6:=[profile?]
	>=dev-haskell/attoparsec-0.10:=[profile?]
	>=dev-haskell/mtl-1.1:=[profile?]
	>=dev-haskell/quickcheck-2.4:2=[profile?]
	dev-haskell/random:=[profile?]
	>=dev-haskell/text-0.11:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?]
	>=dev-haskell/vector-space-0.8:=[profile?]
	>=dev-haskell/vector-th-unbox-0.2.1.0:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	lens? ( >=dev-haskell/lens-3.9:=[profile?] )
	!lens? ( >=dev-haskell/profunctors-3.1.2:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag bug-for-bug bug-for-bug) \
		--flag=-hlint \
		$(cabal_flag lens lens) \
		$(cabal_flag show-internal show-internal) \
		--flag=-werror
}

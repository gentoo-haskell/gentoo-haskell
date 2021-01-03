# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.7.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal

DESCRIPTION="Haskell binding for Qt Quick"
HOMEPAGE="http://www.gekkou.co.uk/software/hsqml/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="enableqmldebugging +forceghcilib +threadedtestsuite +useexithook usepkgconfig"

RDEPEND=">=dev-haskell/tagged-0.4:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.8.2:=
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-devel/gcc[cxx]
"
DEPEND="${RDEPEND}
	dev-haskell/c2hs
	>=dev-haskell/cabal-2.0 <dev-haskell/cabal-2.1
	virtual/pkgconfig
"
	# test? ( >=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.12 )

RESTRICT="test" # requires <dev-haskell/quickcheck-2.12, and maybe X?

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag enableqmldebugging enableqmldebugging) \
		$(cabal_flag forceghcilib forceghcilib) \
		$(cabal_flag threadedtestsuite threadedtestsuite) \
		$(cabal_flag useexithook useexithook) \
		$(cabal_flag usepkgconfig usepkgconfig)
}

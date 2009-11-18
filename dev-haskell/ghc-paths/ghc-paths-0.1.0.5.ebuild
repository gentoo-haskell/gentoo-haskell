# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Knowledge of GHC's installation directories"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/ghc-paths"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_unpack() {
        unpack ${A}

        # non-default setup is know to fail on new cabal, so we make all magic to happen here
        rm "${S}/Setup.hs"
        cp "${FILESDIR}/Setup.lhs" "${S}/"

        # a few things we need to replace, and example values
        # GHC_PATHS_LIBDIR /usr/lib64/ghc-6.12.0.20091010
        # GHC_PATHS_DOCDIR /usr/share/doc/ghc-6.12.0.20091010/html
        # GHC_PATHS_GHC_PKG /usr/bin/ghc-pkg
        # GHC_PATHS_GHC /usr/bin/ghc (be careful: GHC_PATHS_GHC is a substring of GHC_PATHS_GHC_PKG)

        # hardcode stuff above:
        sed \
            -e "s|GHC_PATHS_LIBDIR|\"$(ghc-libdir)\"|" \
            -e "s|GHC_PATHS_DOCDIR|\"/usr/share/doc/ghc-$(ghc-version)/html\"|" \
            -e "s|GHC_PATHS_GHC_PKG|\"$(ghc-getghcpkg)\"|" \
            -e "s|GHC_PATHS_GHC|\"$(ghc-getghc)\"|" \
          -i "${S}/GHC/Paths.hs"
}

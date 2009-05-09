# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bootstrap lib profile"
inherit haskell-cabal eutils

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

# Resolve cyclic dep between filepath and Cabal by using a private copy of
# filepath when building Cabal.
FP_PN=filepath
FP_PV=1.1.0.1
FP_P=${FP_PN}-${FP_PV}


DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz
	http://hackage.haskell.org/packages/archive/${FP_PN}/${FP_PV}/${FP_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.4"

S="${WORKDIR}/${MY_P}"

CABAL_CORE_LIB_GHC_PV="6.10.2 6.10.3"

src_unpack() {
	unpack ${A}

	# We're using the private copy of filepath:
	sed -i -e 's/Build-Depends: filepath >= 1 && < 1.2//' \
		-e '/Other-Modules:/a \
        System.FilePath System.FilePath.Posix System.FilePath.Windows' \
		"${S}/Cabal.cabal"
	# Note: do not replace spaces with tabs on the line above, it'll break
	# things. You'll just have to put up with the repoman warning.

	echo "  Hs-Source-Dirs: ., ../${FP_P}" >> "${S}/Cabal.cabal"
}

src_compile() {
	if ! cabal-is-dummy-lib; then
		einfo "Bootstrapping Cabal..."
		$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
			-o setup || die "compiling Setup.hs failed"
		cabal-configure
		cabal-build
	fi
}

src_install() {
	cabal_src_install

	dodoc LICENSE
}

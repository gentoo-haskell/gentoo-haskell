# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap profile lib"
inherit base haskell-cabal

# Resolve cyclic dep between filepath and Cabal by using a private copy of
# filepath when building Cabal.
FP_PN=filepath
FP_PV=1.1.0.0
FP_P=${FP_PN}-${FP_PV}

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/${P}/${P}.tar.gz
	http://hackage.haskell.org/packages/archive/${FP_PN}/${FP_PV}/${FP_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="doc"

RESTRICT="test"

DEPEND=">=dev-lang/ghc-6.2"

CABAL_CORE_LIB_GHC_PV="6.8.2"

src_unpack() {
	base_src_unpack

	# We're using the private copy of filepath:
	sed -i -e 's/Build-Depends: filepath//' \
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
		$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.lhs \
			-o setup || die "compiling Setup.lhs failed"
		cabal-configure
		cabal-build
	fi
}

src_install() {
	cabal_src_install

	# documentation (install directly)
	if use doc; then
		dohtml -r doc/users-guide
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog README releaseNotes TODO
}

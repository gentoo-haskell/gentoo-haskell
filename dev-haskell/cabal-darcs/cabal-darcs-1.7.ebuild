# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="profile lib"
inherit base haskell-cabal eutils darcs versionator

#Define this just in case we start to have ebuilds with minor version numbers
MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://haskell.org/cabal"
EDARCS_REPOSITORY="http://darcs.haskell.org/cabal"

LICENSE="BSD"
SLOT="${MY_PV}"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.4
	dev-haskell/filepath"

src_compile() {
	einfo "Bootstrapping Cabal..."
	$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
		-o setup || die "compiling Setup.lhs failed"
	cabal-configure
	cabal-build
}

src_install() {
	cabal_src_install

	dodoc changelog README releaseNotes TODO
}

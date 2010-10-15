# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-1.8.0.6-r1.ebuild,v 1.3 2010/09/26 19:41:32 hwoarang Exp $

CABAL_FEATURES="bootstrap lib profile"
inherit haskell-cabal eutils

MY_PN="Cabal"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc"

# Cabal.cabal only depends on base>=1&&<5 and filepath>=1&&<1.2
# filepath has been a ghc core library since ghc 6.6.1, so let's use that as the
# lowest possible ghc version
DEPEND=">=dev-lang/ghc-6.6.1"
RDEPEND="${DEPEND}
		dev-util/pkgconfig"
# cabal uses dev-util/pkgconfig using runtime to resolve C dependencies, so
# repoman's RDEPEND.suspect QA does not apply here

S="${WORKDIR}/${MY_P}"

CABAL_CORE_LIB_GHC_PV="6.12.3"

src_compile() {
	if ! cabal-is-dummy-lib; then
		einfo "Bootstrapping Cabal..."
		$(ghc-getghc) -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
			-o setup || die "compiling Setup.hs failed"
		cabal-configure
		cabal-build
	fi
}

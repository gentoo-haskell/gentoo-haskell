# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base haskell-cabal

DESCRIPTION="Hashed file storage support code."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hashed-storage"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		dev-haskell/dataenc
		dev-haskell/extensible-exceptions
		=dev-haskell/mmap-0.4*
		dev-haskell/mtl
		dev-haskell/zlib
		test? (
			dev-haskell/test-framework
			dev-haskell/test-framework-hunit
			dev-haskell/test-framework-quickcheck2
			>=dev-haskell/quickcheck-2
			dev-haskell/hunit
			dev-haskell/zip-archive
		)"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

PATCHES=("${FILESDIR}/ppc64-hashed-storage-fix.patch")

if use test; then
	CABAL_CONFIGURE_FLAGS="--flags=test"
fi

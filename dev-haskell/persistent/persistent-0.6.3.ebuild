# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:	$

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Type-safe, non-relational, multi-backend persistence."
HOMEPAGE="http://docs.yesodweb.com/book/persistent"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
SRC_URI="$SRC_URI test? ( http://hackage.haskell.org/packages/archive/${PN}-template/${PV}/${PN}-template-${PV}.tar.gz )"
SRC_URI="$SRC_URI test? ( http://hackage.haskell.org/packages/archive/${PN}-sqlite/0.6.2/${PN}-sqlite-0.6.2.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="postgres sqlite3"
RESTRICT="test" # In the bump from 0.6.2 to 0.6.3, upstream removed the tests from the cabal file

RDEPEND="=dev-haskell/blaze-html-0.4*
		=dev-haskell/data-object-0.3*
		=dev-haskell/enumerator-0.4*
		=dev-haskell/monad-control-0.2*
		dev-haskell/mtl
		=dev-haskell/path-pieces-0.0*
		=dev-haskell/pool-0.1*
		<dev-haskell/text-0.12
		<dev-haskell/time-1.3
		=dev-haskell/transformers-0.2*
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( dev-haskell/file-location
			dev-haskell/hunit
			=dev-haskell/hspec-0.9*
			dev-haskell/quickcheck:2
		)"

PDEPEND="postgres? ( >=dev-haskell/hdbc-postgresql-${PV} )
		sqlite3? ( >=dev-haskell/hdbc-sqlite-${PV} )"

src_unpack() {
	default_src_unpack

	if use test; then
		pushd ${S}
		unpack "${PN}-sqlite-0.6.2.tar.gz"
		mv "${PN}-sqlite-0.6.2" "${PN}-sqlite"
		unpack "${PN}-template-${PV}.tar.gz"
		mv "${PN}-template-${PV}" "${PN}-template"
		# TODO: With next package bump above 0.6.3, remove the next 3 lines and remove files/main.hs,
		# upstream will include the file now, see:
		# https://github.com/yesodweb/yesod/issues/135#issuecomment-2268151
		mkdir test
		cd test
		cp "${FILESDIR}/main.hs" .
		popd
	fi
}

src_prepare() {
	sed -e 's@mtl                      >= 2.0     && < 2.1@mtl                      >= 1.0     \&\& < 2.1@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

src_configure() {
	if use test; then
		CABAL_EXTRA_CONFIGURE_FLAGS="--enable-tests"
	fi
	cabal_src_configure
}

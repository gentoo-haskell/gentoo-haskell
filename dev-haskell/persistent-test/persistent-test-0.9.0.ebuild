# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile"
inherit git-2 haskell-cabal

T_PV=0.9.0
S_PV=0.9.0

DESCRIPTION="Tests for Persistent"
HOMEPAGE="http://www.yesodweb.com/book/persistent"
EGIT_REPO_URI="git://github.com/yesodweb/persistent.git"
EGIT_NOUNPACK="1"
SRC_URI="test? ( http://hackage.haskell.org/packages/archive/persistent-template/${T_PV}/persistent-template-${T_PV}.tar.gz )"
SRC_URI="$SRC_URI test? ( http://hackage.haskell.org/packages/archive/persistent-sqlite/${S_PV}/persistent-sqlite-${S_PV}.tar.gz )"

EGIT_SOURCEDIR="${WORKDIR}/persistent"
S="${EGIT_SOURCEDIR}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite3 test"

RDEPEND="dev-haskell/aeson
		dev-haskell/attoparsec
		dev-haskell/base64-bytestring
		dev-haskell/blaze-html
		>=dev-haskell/bson-0.1.6
		dev-haskell/cereal
		dev-haskell/compact-string-fix
		>=dev-haskell/conduit-0.2
		dev-haskell/file-location
		dev-haskell/lifted-base
		dev-haskell/monad-control
		dev-haskell/network
		>=dev-haskell/path-pieces-0.1
		dev-haskell/pool-conduit
		<dev-haskell/postgresql-simple-1.0
		>=dev-haskell/postgresql-libpq-0.6
		dev-haskell/text
		>=dev-haskell/time-1.2
		dev-haskell/transformers
		dev-haskell/transformers-base
		dev-haskell/vector
		dev-haskell/unordered-containers
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( =dev-haskell/file-location-0.4*
			dev-haskell/hunit
			=dev-haskell/hspec-0.9*
			=dev-haskell/quickcheck-2.4*:2
		)"

PDEPEND="sqlite3? ( >=dev-haskell/hdbc-sqlite-${PV} )"

src_unpack() {
	git-2_src_unpack

	if use test; then
		pushd ${S}
		unpack "persistent-sqlite-${S_PV}.tar.gz"
		mv "persistent-sqlite-${S_PV}" "persistent-sqlite"
		unpack "persistent-template-${T_PV}.tar.gz"
		mv "persistent-template-${T_PV}" "persistent-template"
		popd
	fi
}

src_configure() {
	if use test; then
		CABAL_EXTRA_CONFIGURE_FLAGS="--enable-tests"
	fi
	cabal_src_configure
}

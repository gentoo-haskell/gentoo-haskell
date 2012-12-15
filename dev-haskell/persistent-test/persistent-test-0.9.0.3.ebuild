# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="lib profile"
inherit git-2 haskell-cabal

T_PV=0.9.0.1
S_PV=0.9.0.1

DESCRIPTION="Tests for Persistent"
HOMEPAGE="http://www.yesodweb.com/book/persistent"
EGIT_REPO_URI="git://github.com/yesodweb/persistent.git"
EGIT_NOUNPACK="1"
SRC_URI="test? ( mirror://hackage/packages/archive/persistent-template/${T_PV}/persistent-template-${T_PV}.tar.gz )"
SRC_URI="$SRC_URI test? ( mirror://hackage/packages/archive/persistent-sqlite/${S_PV}/persistent-sqlite-${S_PV}.tar.gz )"

EGIT_SOURCEDIR="${WORKDIR}/persistent"
S="${EGIT_SOURCEDIR}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="sqlite3 test"

RDEPEND="dev-haskell/aeson[profile?]
		dev-haskell/attoparsec[profile?]
		dev-haskell/base64-bytestring[profile?]
		dev-haskell/blaze-html[profile?]
		>=dev-haskell/bson-0.1.6[profile?]
		dev-haskell/cereal[profile?]
		dev-haskell/compact-string-fix[profile?]
		>=dev-haskell/conduit-0.4[profile?]
		dev-haskell/file-location[profile?]
		dev-haskell/lifted-base[profile?]
		dev-haskell/monad-control[profile?]
		=dev-haskell/mongodb-1.2*[profile?]
		>=dev-haskell/mysql-0.1.1.3[profile?]
		<dev-haskell/mysql-0.2[profile?]
		>=dev-haskell/mysql-simple-0.2.2.3[profile?]
		<dev-haskell/mysql-simple-0.3[profile?]
		dev-haskell/network[profile?]
		>=dev-haskell/path-pieces-0.1[profile?]
		dev-haskell/pool-conduit[profile?]
		<dev-haskell/postgresql-simple-1.0[profile?]
		>=dev-haskell/postgresql-libpq-0.6[profile?]
		dev-haskell/text[profile?]
		dev-haskell/transformers[profile?]
		dev-haskell/transformers-base[profile?]
		dev-haskell/vector[profile?]
		dev-haskell/unordered-containers[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( =dev-haskell/file-location-0.4*[profile?]
			dev-haskell/hunit[profile?]
			>=dev-haskell/hspec-0.9[profile?]
			<dev-haskell/hspec-1.1[profile?]
			=dev-haskell/quickcheck-2.4*:2[profile?]
		)"

PDEPEND="sqlite3? ( >=dev-haskell/hdbc-sqlite-${PV} )"

src_unpack() {
	git-2_src_unpack

	if use test; then
		pushd "${S}"
		unpack "persistent-sqlite-${S_PV}.tar.gz"
		mv "persistent-sqlite-${S_PV}" "persistent-sqlite"
		unpack "persistent-template-${T_PV}.tar.gz"
		mv "persistent-template-${T_PV}" "persistent-template"
		popd
	fi
}

src_prepare() {
	sed -e 's@hspec >= 0.8 && < 0.10@hspec >= 0.8 \&\& < 1.1@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

src_configure() {
	if use test; then
		CABAL_EXTRA_CONFIGURE_FLAGS="--enable-tests"
	fi
	cabal_src_configure
}

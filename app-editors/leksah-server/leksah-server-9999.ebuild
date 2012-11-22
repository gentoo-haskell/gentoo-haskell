# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal git-2

DESCRIPTION="Metadata collection for leksah"
HOMEPAGE="http://leksah.org"
EGIT_REPO_URI="git://github.com/leksah/leksah-server.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=">=dev-haskell/attoparsec-0.10.0.3[profile?]
		<dev-haskell/attoparsec-0.11[profile?]
		=dev-haskell/attoparsec-enumerator-0.3*[profile?]
		>=dev-haskell/binary-0.5.0.0[profile?]
		<dev-haskell/binary-0.7[profile?]
		=dev-haskell/binary-shared-0.8*[profile?]
		>=dev-haskell/cabal-1.6.0.1[profile?]
		<dev-haskell/cabal-1.15[profile?]
		>=dev-haskell/deepseq-1.1[profile?]
		<dev-haskell/deepseq-1.4[profile?]
		>=dev-haskell/enumerator-0.4.14[profile?]
		<dev-haskell/enumerator-0.5[profile?]
		>=dev-haskell/haddock-2.7.2[profile?]
		<dev-haskell/haddock-2.11[profile?]
		>=dev-haskell/hslogger-1.0.7[profile?]
		<dev-haskell/hslogger-1.3[profile?]
		=dev-haskell/ltk-9999[profile?]
		>=dev-haskell/network-2.2[profile?]
		<dev-haskell/network-3.0[profile?]
		>=dev-haskell/parsec-2.1.0.1[profile?]
		<dev-haskell/parsec-3.2[profile?]
		>=dev-haskell/process-leksah-1.0.1.3[profile?]
		<dev-haskell/process-leksah-1.1[profile?]
		>=dev-haskell/strict-0.3.2[profile?]
		<dev-haskell/strict-0.4[profile?]
		>=dev-haskell/time-1.1[profile?]
		<dev-haskell/time-1.5[profile?]
		>=dev-haskell/transformers-0.2.2.0[profile?]
		<dev-haskell/transformers-0.4[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/cabal-1.10
			>=dev-haskell/hunit-1.2
		)
		"

src_prepare() {
	if has_version "<dev-lang/ghc-7.0.1" && has_version ">=dev-haskell/cabal-1.10.0.0"; then
		# with ghc 6.12 does not work with cabal-1.10, so use ghc-6.12 shipped one
		sed -e 's@build-depends: Cabal >=1.6.0.1 && <1.15@build-depends: Cabal >=1.6.0.1 \&\& <1.9@g' \
			-i "${S}/${PN}.cabal"
	fi
	cabal_chdeps \
		'hslogger >= 1.0.7 && <1.2' 'hslogger >= 1.0.7 && <1.3' \
		'binary >=0.5.0.0 && <0.6' 'binary >=0.5.0.0 && <0.7'
}

src_configure() {
	threaded_flag=""
	if $(ghc-getghc) --info | grep "Support SMP" | grep -q "YES"; then
		threaded_flag="--flags=threaded"
		einfo "$P will be built with threads support"
	else
		threaded_flag="--flags=-threaded"
		einfo "$P will be built without threads support"
	fi
	cabal_src_configure $threaded_flag \
		$(use_enable test tests)
}

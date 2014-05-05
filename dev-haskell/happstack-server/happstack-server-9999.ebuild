# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin lib profile haddock hscolour hoogle test-suite"
inherit darcs haskell-cabal

DESCRIPTION="Web related tools and services."
HOMEPAGE="http://happstack.com"
EDARCS_REPOSITORY="http://patch-tag.com/r/mae/happstack"

S="${WORKDIR}/${P}/${PN}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND="=dev-haskell/base64-bytestring-1.0*:=[profile?]
		>=dev-haskell/blaze-html-0.5:=[profile?]
		<dev-haskell/blaze-html-0.7:=[profile?]
		dev-haskell/extensible-exceptions:=[profile?]
		>=dev-haskell/hslogger-1.0.2:=[profile?]
		dev-haskell/html:=[profile?]
		=dev-haskell/monad-control-0.3*:=[profile?]
		>=dev-haskell/mtl-2:=[profile?]
		<dev-haskell/mtl-2.2:=[profile?]
		>=dev-haskell/network-2.2.3:=[profile?]
		<dev-haskell/parsec-4:=[profile?]
		>=dev-haskell/sendfile-0.7.1:=[profile?]
		<dev-haskell/sendfile-0.8:=[profile?]
		dev-haskell/syb:=[profile?]
		>=dev-haskell/system-filepath-0.3.1:=[profile?]
		>=dev-haskell/text-0.10:=[profile?]
		<dev-haskell/text-0.12:=[profile?]
		>=dev-haskell/threads-0.5:=[profile?]
		dev-haskell/time-compat:=[profile?]
		>=dev-haskell/transformers-0.1.3:=[profile?]
		<dev-haskell/transformers-0.4:=[profile?]
		=dev-haskell/transformers-base-0.4*:=[profile?]
		>=dev-haskell/utf8-string-0.3.4:=[profile?]
		<dev-haskell/utf8-string-0.4:=[profile?]
		dev-haskell/xhtml:=[profile?]
		dev-haskell/zlib:=[profile?]
		>=dev-lang/ghc-6.12.1:=
		"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( dev-haskell/hunit
		)"

src_configure() {
	haskell-cabal_src_configure \
		--flags=network_2_2_3 \
		--flags=template_haskell
}

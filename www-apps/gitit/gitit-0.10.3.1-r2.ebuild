# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Wiki using happstack, git or darcs, and pandoc."
HOMEPAGE="http://gitit.net"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+plugins"

RDEPEND=">=app-text/pandoc-1.12:=[profile?] <app-text/pandoc-1.13:=[profile?]
		>=dev-haskell/base64-bytestring-0.1:=[profile?]
		<dev-haskell/base64-bytestring-1.1:=[profile?]
		>=dev-haskell/blaze-html-0.4:=[profile?]
		<dev-haskell/blaze-html-0.7:=[profile?]
		dev-haskell/cgi:=[profile?]
		>=dev-haskell/configfile-1:=[profile?]
		<dev-haskell/configfile-1.2:=[profile?]
		>=dev-haskell/feed-0.3.6:=[profile?]
		<dev-haskell/feed-0.4:=[profile?]
		=dev-haskell/filestore-0.6*:=[profile?]
		>=dev-haskell/happstack-server-7.0:=[profile?] <dev-haskell/happstack-server-7.4:=[profile?]
		>=dev-haskell/highlighting-kate-0.5.0.1:=[profile?]
		<dev-haskell/highlighting-kate-0.6:=[profile?]
		>=dev-haskell/hslogger-1:=[profile?]
		<dev-haskell/hslogger-1.3:=[profile?]
		>=dev-haskell/hstringtemplate-0.6:=[profile?]
		<dev-haskell/hstringtemplate-0.8:=[profile?]
		>=dev-haskell/http-4000.0:=[profile?]
		<dev-haskell/http-4000.3:=[profile?]
		>=dev-haskell/json-0.4:=[profile?]
		<dev-haskell/json-0.8:=[profile?]
		dev-haskell/mtl:=[profile?]
		>=dev-haskell/network-2.1.0.0:=[profile?]
		<dev-haskell/network-2.5:=[profile?]
		>=dev-haskell/pandoc-types-1.12:=[profile?] <dev-haskell/pandoc-types-1.13:=[profile?]
		dev-haskell/parsec:=[profile?]
		dev-haskell/random:=[profile?]
		>=dev-haskell/recaptcha-0.1:=[profile?]
		dev-haskell/safe:=[profile?]
		>dev-haskell/sha-1:=[profile?]
		<dev-haskell/sha-1.7:=[profile?]
		dev-haskell/syb:=[profile?]
		>=dev-haskell/tagsoup-0.13:=[profile?] <dev-haskell/tagsoup-0.14:=[profile?]
		dev-haskell/text:=[profile?]
		=dev-haskell/url-2.1*:=[profile?]
		=dev-haskell/utf8-string-0.3*:=[profile?]
		dev-haskell/xhtml:=[profile?]
		>=dev-haskell/xml-1.3.5:=[profile?]
		=dev-haskell/xss-sanitize-0.3*:=[profile?]
		=dev-haskell/zlib-0.5*:=[profile?]
		>=dev-lang/ghc-6.12.1:=
		plugins? ( dev-haskell/ghc-paths:=[profile?]
		)"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pandoc-1.12.patch

	cabal_chdeps \
		'happstack-server >= 7.0 && < 7.2' 'happstack-server >= 7.0 && < 7.4'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag plugins plugins)
}

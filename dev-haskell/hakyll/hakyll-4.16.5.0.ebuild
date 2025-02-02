# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.9.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A static website compiler library"
HOMEPAGE="https://jaspervdj.be/hakyll"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="buildwebsite +checkexternal +previewserver +usepandoc +watchserver"

PATCHES=(
	"${FILESDIR}/${PN}-4.16.2.0-disable-flakey-tests.patch"
)

RDEPEND=">=dev-haskell/blaze-html-0.5:=[profile?] <dev-haskell/blaze-html-0.10:=[profile?]
	>=dev-haskell/data-default-0.4:=[profile?] <dev-haskell/data-default-0.9:=[profile?]
	>=dev-haskell/file-embed-0.0.10.1:=[profile?] <dev-haskell/file-embed-0.0.17:=[profile?]
	>=dev-haskell/hashable-1.0:=[profile?] <dev-haskell/hashable-2:=[profile?]
	>=dev-haskell/lrucache-1.1.1:=[profile?] <dev-haskell/lrucache-1.3:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?]
	>=dev-haskell/optparse-applicative-0.12:=[profile?] <dev-haskell/optparse-applicative-0.19:=[profile?]
	>=dev-haskell/parsec-3.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-1.4:=[profile?]
	>=dev-haskell/regex-tdfa-1.1:=[profile?] <dev-haskell/regex-tdfa-1.4:=[profile?]
	>=dev-haskell/resourcet-1.1:=[profile?] <dev-haskell/resourcet-1.4:=[profile?]
	>=dev-haskell/scientific-0.3.4:=[profile?] <dev-haskell/scientific-0.4:=[profile?]
	>=dev-haskell/tagsoup-0.13.1:=[profile?] <dev-haskell/tagsoup-0.15:=[profile?]
	>=dev-haskell/time-locale-compat-0.1:=[profile?] <dev-haskell/time-locale-compat-0.2:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-haskell/wai-app-static-3.1:=[profile?] <dev-haskell/wai-app-static-3.2:=[profile?]
	>=dev-haskell/yaml-0.8.11:=[profile?] <dev-haskell/yaml-0.12:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	>=dev-haskell/aeson-1.0:=[profile?] <dev-haskell/aeson-2.3:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-2.2:=[profile?]
	buildwebsite? ( >=dev-haskell/pandoc-types-1.22:=[profile?] <dev-haskell/pandoc-types-1.24:=[profile?]
			>=dev-haskell/pandoc-2.11:=[profile?] <dev-haskell/pandoc-3.7:=[profile?] )
	checkexternal? ( >=dev-haskell/http-conduit-2.2:=[profile?] <dev-haskell/http-conduit-2.4:=[profile?] )
	previewserver? ( >=dev-haskell/fsnotify-0.2:=[profile?] <dev-haskell/fsnotify-0.5:=[profile?]
				>=dev-haskell/http-types-0.9:=[profile?] <dev-haskell/http-types-0.13:=[profile?]
				>=dev-haskell/wai-3.2:=[profile?] <dev-haskell/wai-3.3:=[profile?]
				>=dev-haskell/warp-3.2:=[profile?] <dev-haskell/warp-3.5:=[profile?] )
	!previewserver? ( checkexternal? ( >=dev-haskell/http-types-0.7:=[profile?] <dev-haskell/http-types-0.13:=[profile?] )
				watchserver? ( >=dev-haskell/fsnotify-0.2:=[profile?] <dev-haskell/fsnotify-0.5:=[profile?] ) )
	usepandoc? ( >=dev-haskell/pandoc-types-1.22:=[profile?] <dev-haskell/pandoc-types-1.24:=[profile?]
			>=dev-haskell/pandoc-2.11:=[profile?] <dev-haskell/pandoc-3.7:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/quickcheck-2.8 <dev-haskell/quickcheck-2.16
		>=dev-haskell/tasty-0.11 <dev-haskell/tasty-1.6
		>=dev-haskell/tasty-golden-2.3 <dev-haskell/tasty-golden-2.4
		>=dev-haskell/tasty-hunit-0.9 <dev-haskell/tasty-hunit-0.11
		>=dev-haskell/tasty-quickcheck-0.8 <dev-haskell/tasty-quickcheck-0.12 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag buildwebsite buildwebsite) \
		$(cabal_flag checkexternal checkexternal) \
		$(cabal_flag previewserver previewserver) \
		$(cabal_flag usepandoc usepandoc) \
		$(cabal_flag watchserver watchserver)
}

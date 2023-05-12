# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#hackport: flags: brittany:hls_formatters_brittany,floskell:hls_formatters_floskell,fourmolu:hls_formatters_fourmolu,ormolu:hls_formatters_ormolu,refactor:hls_formatters_refactor,stylishhaskell:hls_formatters_stylish-haskell,alternateNumberFormat:hls_plugins_alternate-number-format,cabal:hls_plugins_cabal,cabalfmt:hls_plugins_cabal-fmt,callHierarchy:hls_plugins_call-hierarchy,changeTypeSignature:hls_plugins_change-type-signature,class:hls_plugins_class,codeRange:hls_plugins_code-range,eval:hls_plugins_eval,explicitFields:hls_plugins_explicit-fields,explicitFixity:hls_plugins_explicit-fixity,gadt:hls_plugins_gadt,haddockComments:hls_plugins_haddock-comments,hlint:hls_plugins_hlint,importLens:hls_plugins_import-lens,moduleName:hls_plugins_module-name,pragmas:hls_plugins_pragmas,qualifyImportedNames:hls_plugins_qualify-imported-names,refineImports:hls_plugins_refine-imports,rename:hls_plugins_rename,retrie:hls_plugins_retrie,splice:hls_plugins_splice,stan:hls_plugins_stan,tactic:hls_plugins_wingman,-dynamic,+ignore-plugins-ghc-bounds,-pedantic

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

# hololeap (2022-09-25)
# TODO: Single test failure
# Use -p '/Overrides -Werror/' to rerun this test only.
RESTRICT="test"

DESCRIPTION="LSP server for GHC"
HOMEPAGE="https://github.com/haskell/haskell-language-server#readme"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

# Disabled:
# - hls_plugins_stan: Requires ghc < 9
# - hls_plugins_cabal-fmt: Requires cabal >= 3.8
# - hls_plugins_call-hierarchy: Still depending on ghcide < 1.9
# - hls_plugins_class: Requires ghc < 9.1
# - hls_plugins_haddock-comments: Requires ghc < 9.1
# - hls_formatters_brittany: Requires ghc < 9.1
# - hls_plugins_wingman: Requires ghc < 9.1
IUSE_HLS_PLUGINS="
	+hls_plugins_alternate-number-format
	+hls_plugins_cabal
	+hls_plugins_change-type-signature
	+hls_plugins_code-range
	+hls_plugins_eval
	+hls_plugins_explicit-fields
	+hls_plugins_explicit-fixity
	+hls_plugins_hlint
	+hls_plugins_import-lens
	+hls_plugins_gadt
	+hls_plugins_module-name
	+hls_plugins_pragmas
	+hls_plugins_qualify-imported-names
	+hls_plugins_refine-imports
	+hls_plugins_rename
	+hls_plugins_retrie
	+hls_plugins_splice
"

IUSE_HLS_FORMATTERS="
	+hls_formatters_floskell
	+hls_formatters_fourmolu
	+hls_formatters_ormolu
	+hls_formatters_refactor
	+hls_formatters_stylish-haskell
"

IUSE="
	${IUSE_HLS_PLUGINS}
	${IUSE_HLS_FORMATTERS}
"

CABAL_TEST_REQUIRED_BINS=(
	haskell-language-server
)

# Disabled:
# hls_formatters_brittany? ( >=dev-haskell/hls-brittany-plugin-1.1:=[profile?] <dev-haskell/hls-brittany-plugin-1.2:=[profile?] )
# hls_plugins_cabal-fmt? ( >=dev-haskell/hls-cabal-fmt-plugin-0.1.0.0:=[profile?] <dev-haskell/hls-cabal-fmt-plugin-0.2:=[profile?] )
# hls_plugins_class? ( >=dev-haskell/hls-class-plugin-1.1:=[profile?] <dev-haskell/hls-class-plugin-1.2:=[profile?] )
# hls_plugins_stan? ( >=dev-haskell/hls-stan-plugin-1.0:=[profile?] <dev-haskell/hls-stan-plugin-1.1:=[profile?] )
# hls_plugins_call-hierarchy? ( >=dev-haskell/hls-call-hierarchy-plugin-1.1:=[profile?] <dev-haskell/hls-call-hierarchy-plugin-1.2:=[profile?] )
# hls_plugins_haddock-comments? ( >=dev-haskell/hls-haddock-comments-plugin-1.1:=[profile?] <dev-haskell/hls-haddock-comments-plugin-1.2:=[profile?] )
# hls_plugins_wingman? ( >=dev-haskell/hls-tactics-plugin-1.8:=[profile?] <dev-haskell/hls-tactics-plugin-1.9:=[profile?] )
RDEPEND="
	dev-haskell/aeson:=[profile?]
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/base16-bytestring:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/extra:=[profile?]
	dev-haskell/ghc-paths:=[profile?]
	>=dev-haskell/ghcide-1.9:=[profile?] <dev-haskell/ghcide-1.10:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/githash:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hie-bios:=[profile?]
	dev-haskell/hiedb:=[profile?]
	>dev-haskell/hls-graph-1.7.0.0:=[profile?]
	>=dev-haskell/hls-plugin-api-1.6:=[profile?] <dev-haskell/hls-plugin-api-1.7:=[profile?]
	dev-haskell/hslogger:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lsp:=[profile?]
	dev-haskell/lsp-types:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/optparse-simple:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/safe-exceptions:=[profile?]
	dev-haskell/sqlite-simple:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/temporary:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.6.3:=
	hls_formatters_floskell? ( >dev-haskell/hls-floskell-plugin-1.0.1.1:=[profile?] <dev-haskell/hls-floskell-plugin-1.1:=[profile?] )
	hls_formatters_fourmolu? ( >=dev-haskell/hls-fourmolu-plugin-1.1:=[profile?] <dev-haskell/hls-fourmolu-plugin-1.2:=[profile?] )
	hls_formatters_ormolu? ( >=dev-haskell/hls-ormolu-plugin-1.0:=[profile?] <dev-haskell/hls-ormolu-plugin-1.1:=[profile?] )
	hls_formatters_refactor? ( >=dev-haskell/hls-refactor-plugin-1.1:=[profile?] <dev-haskell/hls-refactor-plugin-1.2:=[profile?] )
	hls_formatters_stylish-haskell? ( >=dev-haskell/hls-stylish-haskell-plugin-1.0:=[profile?] <dev-haskell/hls-stylish-haskell-plugin-1.1:=[profile?] )
	hls_plugins_alternate-number-format? ( >=dev-haskell/hls-alternate-number-format-plugin-1.3:=[profile?] <dev-haskell/hls-alternate-number-format-plugin-1.4:=[profile?] )
	hls_plugins_cabal? ( >=dev-haskell/hls-cabal-plugin-0.1:=[profile?] <dev-haskell/hls-cabal-plugin-0.2:=[profile?] )
	hls_plugins_change-type-signature? ( >dev-haskell/hls-change-type-signature-plugin-1.1 <dev-haskell/hls-change-type-signature-plugin-1.2 )
	hls_plugins_code-range? ( >=dev-haskell/hls-code-range-plugin-1.1:=[profile?] <dev-haskell/hls-code-range-plugin-1.2:=[profile?] )
	hls_plugins_eval? ( >=dev-haskell/hls-eval-plugin-1.4:=[profile?] <dev-haskell/hls-eval-plugin-1.5:=[profile?] )
	hls_plugins_explicit-fields? ( >=dev-haskell/hls-explicit-record-fields-plugin-1.0:=[profile?] <dev-haskell/hls-explicit-record-fields-plugin-1.1:=[profile?] )
	hls_plugins_explicit-fixity? ( >=dev-haskell/hls-explicit-fixity-plugin-1.1:=[profile?] <dev-haskell/hls-explicit-fixity-plugin-1.2:=[profile?] )
	hls_plugins_gadt? ( >=dev-haskell/hls-gadt-plugin-1.0:=[profile?] <dev-haskell/hls-gadt-plugin-1.1:=[profile?] )
	hls_plugins_hlint? ( >=dev-haskell/hls-hlint-plugin-1.1:=[profile?] <dev-haskell/hls-hlint-plugin-1.2:=[profile?] )
	hls_plugins_import-lens? ( >=dev-haskell/hls-explicit-imports-plugin-1.2:=[profile?] <dev-haskell/hls-explicit-imports-plugin-1.3:=[profile?] )
	hls_plugins_module-name? ( >=dev-haskell/hls-module-name-plugin-1.1:=[profile?] <dev-haskell/hls-module-name-plugin-1.2:=[profile?] )
	hls_plugins_pragmas? ( >=dev-haskell/hls-pragmas-plugin-1.0:=[profile?] <dev-haskell/hls-pragmas-plugin-1.1:=[profile?] )
	hls_plugins_qualify-imported-names? ( >=dev-haskell/hls-qualify-imported-names-plugin-1.0:=[profile?] <dev-haskell/hls-qualify-imported-names-plugin-1.1:=[profile?] )
	hls_plugins_refine-imports? ( >=dev-haskell/hls-refine-imports-plugin-1.0:=[profile?] <dev-haskell/hls-refine-imports-plugin-1.1:=[profile?] )
	hls_plugins_rename? ( >dev-haskell/hls-rename-plugin-1.0.0.2:=[profile?] <dev-haskell/hls-rename-plugin-1.1:=[profile?] )
	hls_plugins_retrie? ( >dev-haskell/hls-retrie-plugin-1.0.2.1:=[profile?] <dev-haskell/hls-retrie-plugin-1.1:=[profile?] )
	hls_plugins_splice? ( >=dev-haskell/hls-splice-plugin-1.0.0.1:=[profile?] <dev-haskell/hls-splice-plugin-1.1:=[profile?] )
"

DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
	test? (
		dev-haskell/ghcide[test-exe]
		dev-haskell/ghcide-test-utils
		>=dev-haskell/hls-test-utils-1.5 <dev-haskell/hls-test-utils-1.6
		dev-haskell/hspec-expectations
		dev-haskell/lens-aeson
		dev-haskell/lsp-test
		dev-haskell/lsp-types
		)
"

src_configure() {
	haskell-cabal_src_configure \
		--flag=-brittany \
		$(cabal_flag hls_formatters_floskell floskell) \
		$(cabal_flag hls_formatters_fourmolu fourmolu) \
		$(cabal_flag hls_formatters_ormolu ormolu) \
		$(cabal_flag hls_formatters_refactor refactor) \
		$(cabal_flag hls_formatters_stylish-haskell stylishhaskell) \
		$(cabal_flag hls_plugins_alternate-number-format alternateNumberFormat) \
		$(cabal_flag hls_plugins_cabal cabal) \
		--flag=-cabalfmt \
		--flag=-callHierarchy \
		$(cabal_flag hls_plugins_change-type-signature changeTypeSignature) \
		--flag=-class \
		$(cabal_flag hls_plugins_code-range codeRange) \
		$(cabal_flag hls_plugins_eval eval) \
		$(cabal_flag hls_plugins_explicit-fields explicitFields) \
		$(cabal_flag hls_plugins_explicit-fixity explicitFixity) \
		$(cabal_flag hls_plugins_gadt gadt) \
		--flag=-haddockComments \
		$(cabal_flag hls_plugins_hlint hlint) \
		$(cabal_flag hls_plugins_import-lens importLens) \
		$(cabal_flag hls_plugins_module-name moduleName) \
		$(cabal_flag hls_plugins_pragmas pragmas) \
		$(cabal_flag hls_plugins_qualify-imported-names qualifyImportedNames) \
		$(cabal_flag hls_plugins_refine-imports refineImports) \
		$(cabal_flag hls_plugins_rename rename) \
		$(cabal_flag hls_plugins_retrie retrie) \
		$(cabal_flag hls_plugins_splice splice) \
		--flag=-stan \
		--flag=-tactic \
		--flag=-dynamic \
		--flag=ignore-plugins-ghc-bounds \
		--flag=-pedantic
}

src_test() {
	# Limit tasty threads to avoid random failures
	# See: <https://github.com/haskell/haskell-language-server/issues/3224#issuecomment-1257070277>
	export TASTY_NUM_THREADS=1
	haskell-cabal_src_test
}

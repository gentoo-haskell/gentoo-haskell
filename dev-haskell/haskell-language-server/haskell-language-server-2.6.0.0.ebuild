# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#hackport: flags: alternateNumberFormat:hls_plugins_alternate-number-format,cabal:hls_plugins_cabal,cabalfmt:hls_plugins_cabal-fmt,callHierarchy:hls_plugins_call-hierarchy,changeTypeSignature:hls_plugins_change-type-signature,class:hls_plugins_class,codeRange:hls_plugins_code-range,eval:hls_plugins_eval,explicitFields:hls_plugins_explicit-fields,explicitFixity:hls_plugins_explicit-fixity,floskell:hls_plugins_floskell,fourmolu:hls_plugins_fourmolu,gadt:hls_plugins_gadt,hlint:hls_plugins_hlint,importLens:hls_plugins_import-lens,moduleName:hls_plugins_module-name,ormolu:hls_plugins_ormolu,overloadedRecordDot:hls_plugins_overloaded-record-dot,pragmas:hls_plugins_pragmas,qualifyImportedNames:hls_plugins_qualify-imported-names,refactor:hls_plugins_refactor,rename:hls_plugins_rename,retrie:hls_plugins_retrie,semanticTokens:hls_plugins_semantic-tokens,splice:hls_plugins_splice,stan:hls_plugins_stan,stylishhaskell:hls_plugins_stylish-haskell,-dynamic,+ignore-plugins-ghc-bounds,-pedantic

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal

RESTRICT="test" # Depends on masked ghcide-test-utils

DESCRIPTION="LSP server for GHC"
HOMEPAGE="https://github.com/haskell/haskell-language-server#readme"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

# Disabled:
# - hls_plugins_class: Requires ghc-exactprint < 1.1
# - hls_plugins_fourmolu: Requires masked package fourmolu
# - hls_plugins_ormolu: Requires masked package ormolu
# - hls_plugins_stan: Depends on ghc >8.8.1 <=9.2.3 || >=9.4.0 <9.10.0
IUSE="
	+hls_plugins_alternate-number-format
	+hls_plugins_cabal
	+hls_plugins_cabal-fmt
	+hls_plugins_call-hierarchy
	+hls_plugins_change-type-signature
	+hls_plugins_code-range
	+hls_plugins_eval
	+hls_plugins_explicit-fields
	+hls_plugins_explicit-fixity
	+hls_plugins_floskell
	+hls_plugins_gadt
	+hls_plugins_hlint
	+hls_plugins_import-lens
	+hls_plugins_module-name
	+hls_plugins_overloaded-record-dot
	+hls_plugins_pragmas
	+hls_plugins_qualify-imported-names
	+hls_plugins_refactor
	+hls_plugins_rename
	+hls_plugins_retrie
	+hls_plugins_semantic-tokens
	+hls_plugins_splice
	+hls_plugins_stylish-haskell
"

CABAL_TEST_REQUIRED_BINS=(
	haskell-language-server
)

# Disabled:
# hls_plugins_class? ( ~dev-haskell/hls-class-plugin-2.6.0.0:=[profile?] )
# hls_plugins_fourmolu? ( ~dev-haskell/hls-fourmolu-plugin-2.6.0.0:=[profile?] )
# hls_plugins_ormolu? ( ~dev-haskell/hls-ormolu-plugin-2.6.0.0:=[profile?] )
# hls_plugins_stan? ( ~dev-haskell/hls-stan-plugin-2.6.0.0:=[profile?] )
RDEPEND="
	dev-haskell/aeson:=[profile?]
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/async:=[profile?]
	dev-haskell/base16-bytestring:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/extra:=[profile?]
	dev-haskell/ghc-paths:=[profile?]
	~dev-haskell/ghcide-2.6.0.0:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/githash:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hie-bios:=[profile?]
	dev-haskell/hiedb:=[profile?]
	>=dev-haskell/hls-graph-2.6:=[profile?] <dev-haskell/hls-graph-2.7
	~dev-haskell/hls-plugin-api-2.6.0.0:=[profile?]
	dev-haskell/lens:=[profile?]
	>=dev-haskell/lsp-2.3:=[profile?] <dev-haskell/lsp-2.4
	>=dev-haskell/lsp-types-2.1:=[profile?] <dev-haskell/lsp-types-2.1.1
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/optparse-simple:=[profile?]
	>=dev-haskell/prettyprinter-1.7:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/safe-exceptions:=[profile?]
	dev-haskell/sqlite-simple:=[profile?]
	dev-haskell/stm:=[profile?]
	dev-haskell/temporary:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-9.2:=
	hls_plugins_alternate-number-format? ( ~dev-haskell/hls-alternate-number-format-plugin-2.6.0.0:=[profile?] )
	hls_plugins_cabal? ( ~dev-haskell/hls-cabal-plugin-2.6.0.0:=[profile?] )
	hls_plugins_cabal-fmt? ( ~dev-haskell/hls-cabal-fmt-plugin-2.6.0.0:=[profile?] )
	hls_plugins_call-hierarchy? ( ~dev-haskell/hls-call-hierarchy-plugin-2.6.0.0:=[profile?] )
	hls_plugins_change-type-signature? ( ~dev-haskell/hls-change-type-signature-plugin-2.6.0.0:=[profile?] )
	hls_plugins_code-range? ( ~dev-haskell/hls-code-range-plugin-2.6.0.0:=[profile?] )
	hls_plugins_eval? ( ~dev-haskell/hls-eval-plugin-2.6.0.0:=[profile?] )
	hls_plugins_explicit-fields? ( ~dev-haskell/hls-explicit-record-fields-plugin-2.6.0.0:=[profile?] )
	hls_plugins_explicit-fixity? ( ~dev-haskell/hls-explicit-fixity-plugin-2.6.0.0:=[profile?] )
	hls_plugins_floskell? ( ~dev-haskell/hls-floskell-plugin-2.6.0.0:=[profile?] )
	hls_plugins_gadt? ( ~dev-haskell/hls-gadt-plugin-2.6.0.0:=[profile?] )
	hls_plugins_hlint? ( ~dev-haskell/hls-hlint-plugin-2.6.0.0:=[profile?] )
	hls_plugins_import-lens? ( ~dev-haskell/hls-explicit-imports-plugin-2.6.0.0:=[profile?] )
	hls_plugins_module-name? ( ~dev-haskell/hls-module-name-plugin-2.6.0.0:=[profile?] )
	hls_plugins_overloaded-record-dot? ( ~dev-haskell/hls-overloaded-record-dot-plugin-2.6.0.0:=[profile?] )
	hls_plugins_pragmas? ( ~dev-haskell/hls-pragmas-plugin-2.6.0.0:=[profile?] )
	hls_plugins_qualify-imported-names? ( ~dev-haskell/hls-qualify-imported-names-plugin-2.6.0.0:=[profile?] )
	hls_plugins_refactor? ( ~dev-haskell/hls-refactor-plugin-2.6.0.0:=[profile?] )
	hls_plugins_rename? ( ~dev-haskell/hls-rename-plugin-2.6.0.0:=[profile?] )
	hls_plugins_retrie? ( ~dev-haskell/hls-retrie-plugin-2.6.0.0:=[profile?] )
	hls_plugins_semantic-tokens? ( ~dev-haskell/hls-semantic-tokens-plugin-2.6.0.0:=[profile?] )
	hls_plugins_splice? ( ~dev-haskell/hls-splice-plugin-2.6.0.0:=[profile?] )
	hls_plugins_stylish-haskell? ( ~dev-haskell/hls-stylish-haskell-plugin-2.6.0.0:=[profile?] )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
"
#	test? (
#		dev-haskell/ghcide
#		dev-haskell/ghcide-test-utils
#		~dev-haskell/hls-test-utils-2.6.0.0
#		dev-haskell/hspec-expectations
#		dev-haskell/lens-aeson
#		dev-haskell/lsp-test
#		dev-haskell/lsp-types
#		dev-haskell/row-types
#	)

src_configure() {
	config_flags=(
		$(cabal_flag hls_plugins_alternate-number-format alternateNumberFormat)
		$(cabal_flag hls_plugins_cabal cabal)
		$(cabal_flag hls_plugins_cabal-fmt cabalfmt)
		$(cabal_flag hls_plugins_call-hierarchy callHierarchy)
		$(cabal_flag hls_plugins_change-type-signature changeTypeSignature)
		$(cabal_flag hls_plugins_code-range codeRange)
		$(cabal_flag hls_plugins_eval eval)
		$(cabal_flag hls_plugins_explicit-fields explicitFields)
		$(cabal_flag hls_plugins_explicit-fixity explicitFixity)
		$(cabal_flag hls_plugins_floskell floskell)
		$(cabal_flag hls_plugins_gadt gadt)
		$(cabal_flag hls_plugins_hlint hlint)
		$(cabal_flag hls_plugins_import-lens importLens)
		$(cabal_flag hls_plugins_module-name moduleName)
		$(cabal_flag hls_plugins_overloaded-record-dot overloadedRecordDot)
		$(cabal_flag hls_plugins_pragmas pragmas)
		$(cabal_flag hls_plugins_qualify-imported-names qualifyImportedNames)
		$(cabal_flag hls_plugins_refactor refactor)
		$(cabal_flag hls_plugins_rename rename)
		$(cabal_flag hls_plugins_retrie retrie)
		$(cabal_flag hls_plugins_semantic-tokens semanticTokens)
		$(cabal_flag hls_plugins_splice splice)
		$(cabal_flag hls_plugins_stylish-haskell stylishhaskell)
		--flag=-class
		--flag=-fourmolu
		--flag=-ormolu
		--flag=-stan
		--flag=-dynamic
		--flag=ignore-plugins-ghc-bounds
		--flag=-pedantic
	)

	haskell-cabal_src_configure "${config_flags[@]}"
}

# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#hackport: flags: alternateNumberFormat:hls_plugins_alternate-number-format,cabal:hls_plugins_cabal,cabalfmt:hls_plugins_cabal-fmt,cabalgild:hls_plugins_cabal-gild,callHierarchy:hls_plugins_call-hierarchy,changeTypeSignature:hls_plugins_change-type-signature,class:hls_plugins_class,codeRange:hls_plugins_code-range,eval:hls_plugins_eval,explicitFields:hls_plugins_explicit-fields,explicitFixity:hls_plugins_explicit-fixity,floskell:hls_plugins_floskell,fourmolu:hls_plugins_fourmolu,gadt:hls_plugins_gadt,hlint:hls_plugins_hlint,importLens:hls_plugins_import-lens,moduleName:hls_plugins_module-name,notes:hls_plugins_notes,ormolu:hls_plugins_ormolu,overloadedRecordDot:hls_plugins_overloaded-record-dot,pragmas:hls_plugins_pragmas,qualifyImportedNames:hls_plugins_qualify-imported-names,refactor:hls_plugins_refactor,rename:hls_plugins_rename,retrie:hls_plugins_retrie,semanticTokens:hls_plugins_semantic-tokens,splice:hls_plugins_splice,stan:hls_plugins_stan,stylishhaskell:hls_plugins_stylish-haskell,-dynamic,+ghc-lib,+ignore-plugins-ghc-bounds,-pedantic,-isolateCabalfmtTests

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite
inherit haskell-cabal

DESCRIPTION="LSP server for GHC"
HOMEPAGE="https://github.com/haskell/haskell-language-server#readme"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

# Disabled:
# - hls_plugins_fourmolu: Requires masked package fourmolu
# - hls_plugins_ormolu: Requires masked package ormolu
# - hls_plugins_stan: Depends on ghc >8.8.1 <=9.2.3 || >=9.4.0 <9.10.0
IUSE="
	+hls_plugins_alternate-number-format
	+hls_plugins_cabal
	+hls_plugins_cabal-fmt
	+hls_plugins_cabal-gild
	+hls_plugins_call-hierarchy
	+hls_plugins_change-type-signature
	+hls_plugins_class
	+hls_plugins_code-range
	+hls_plugins_eval
	+hls_plugins_explicit-fields
	+hls_plugins_explicit-fixity
	+hls_plugins_floskell
	+hls_plugins_gadt
	+hls_plugins_hlint
	+hls_plugins_import-lens
	+hls_plugins_module-name
	+hls_plugins_notes
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

RESTRICT="test" # Depends on masked ghcide-test-utils

CABAL_TEST_REQUIRED_BINS=(
	haskell-language-server
)

# Disabled:
# hls_plugins_fourmolu? ( )
# hls_plugins_ormolu? ( )
# hls_plugins_stan? ( )
RDEPEND="
	dev-haskell/aeson-pretty:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/extra-1.7.4:=[profile?]
	~dev-haskell/ghcide-2.8.0.0:=[profile?]
	>=dev-haskell/githash-0.1.6.1:=[profile?]
	dev-haskell/hie-bios:=[profile?]
	~dev-haskell/hls-plugin-api-2.8.0.0:=[profile?]
	>=dev-haskell/lsp-2.4:=[profile?] <dev-haskell/lsp-2.5
	>=dev-haskell/lsp-types-2.1:=[profile?] <dev-haskell/lsp-types-2.2
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/optparse-simple:=[profile?]
	>=dev-haskell/prettyprinter-1.7:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	>=dev-lang/ghc-9.2:=
	hls_plugins_alternate-number-format? (
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/regex-tdfa:=[profile?]
		dev-haskell/syb:=[profile?]
	)
	hls_plugins_cabal? (
		>=dev-haskell/cabal-syntax-3.7:=[profile?]
		dev-haskell/hashable:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		>=dev-haskell/regex-tdfa-1.3.1:=[profile?] <dev-haskell/regex-tdfa-1.4
		dev-haskell/text-rope:=[profile?]
		>=dev-haskell/unordered-containers-0.2.10:=[profile?]
	)
	hls_plugins_cabal-fmt? (
		dev-haskell/lens:=[profile?]
		dev-haskell/process-extras:=[profile?]
	)
	hls_plugins_cabal-gild? (
		dev-haskell/process-extras:=[profile?]
	)
	hls_plugins_call-hierarchy? (
		dev-haskell/aeson:=[profile?]
		>=dev-haskell/hiedb-0.6:=[profile?] <dev-haskell/hiedb-0.7
		dev-haskell/lens:=[profile?]
		dev-haskell/sqlite-simple:=[profile?]
	)
	hls_plugins_change-type-signature? (
		dev-haskell/regex-tdfa:=[profile?]
		dev-haskell/syb:=[profile?]
	)
	hls_plugins_class? (
		dev-haskell/aeson:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		>=dev-haskell/ghc-exactprint-1.5:=[profile?]
		dev-haskell/lens:=[profile?]
	)
	hls_plugins_code-range? (
		dev-haskell/hashable:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/semigroupoids:=[profile?]
		dev-haskell/vector:=[profile?]
	)
	hls_plugins_eval? (
		dev-haskell/aeson:=[profile?]
		>=dev-haskell/diff-0.4:=[profile?] <dev-haskell/diff-0.5
		dev-haskell/dlist:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		>=dev-haskell/megaparsec-9:=[profile?]
		>=dev-haskell/parser-combinators-1.2:=[profile?]
		dev-haskell/unliftio:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
	)
	hls_plugins_explicit-fields? (
		dev-haskell/aeson:=[profile?]
		dev-haskell/lens:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/syb:=[profile?]
	)
	hls_plugins_explicit-fixity? (
		dev-haskell/hashable:=[profile?]
	)
	hls_plugins_floskell? (
		>=dev-haskell/floskell-0.11:=[profile?] <dev-haskell/floskell-0.12
	)
	hls_plugins_gadt? (
		dev-haskell/aeson:=[profile?]
		dev-haskell/ghc-exactprint:=[profile?]
		dev-haskell/lens:=[profile?]
	)
	hls_plugins_hlint? (
		dev-haskell/aeson:=[profile?]
		dev-haskell/apply-refact:=[profile?]
		dev-haskell/hashable:=[profile?]
		dev-haskell/ghc-lib-parser:=[profile?]
		dev-haskell/ghc-lib-parser-ex:=[profile?]
		>=dev-haskell/hlint-3.5:=[profile?] <dev-haskell/hlint-3.9
		dev-haskell/lens:=[profile?]
		dev-haskell/refact:=[profile?]
		dev-haskell/regex-tdfa:=[profile?]
		dev-haskell/temporary:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
	)
	hls_plugins_import-lens? (
		dev-haskell/aeson:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
	)
	hls_plugins_module-name? (
		dev-haskell/aeson:=[profile?]
	)
	hls_plugins_notes? (
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		>=dev-haskell/regex-tdfa-1.3.1:=[profile?]
		dev-haskell/text-rope:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
	)
	hls_plugins_overloaded-record-dot? (
		dev-haskell/aeson:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/syb:=[profile?]
	)
	hls_plugins_pragmas? (
		dev-haskell/fuzzy:=[profile?]
		dev-haskell/lens:=[profile?]
	)
	hls_plugins_qualify-imported-names? (
		dev-haskell/dlist:=[profile?]
		dev-haskell/lens:=[profile?]
	)
	hls_plugins_refactor? (
		dev-haskell/data-default:=[profile?]
		dev-haskell/dlist:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/parser-combinators:=[profile?]
		dev-haskell/regex-applicative:=[profile?]
		dev-haskell/regex-tdfa:=[profile?]
		dev-haskell/retrie:=[profile?]
		dev-haskell/syb:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
		|| (
			<dev-haskell/ghc-exactprint-1
			>=dev-haskell/ghc-exactprint-1.4
		)
		dev-haskell/ghc-exactprint:=[profile?]
	)
	hls_plugins_rename? (
		dev-haskell/hashable:=[profile?]
		>=dev-haskell/hiedb-0.6:=[profile?] <dev-haskell/hiedb-0.7
		dev-haskell/hie-compat:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/mod:=[profile?]
		dev-haskell/syb:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
	)
	hls_plugins_retrie? (
		dev-haskell/aeson:=[profile?]
		dev-haskell/hashable:=[profile?]
		dev-haskell/lens:=[profile?]
		>=dev-haskell/retrie-0.1.1:=[profile?]
		dev-haskell/safe-exceptions:=[profile?]
		dev-haskell/unordered-containers:=[profile?]
	)
	hls_plugins_semantic-tokens? (
		dev-haskell/data-default:=[profile?]
		dev-haskell/dlist:=[profile?]
		~dev-haskell/hls-graph-2.8.0.0:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/stm-containers:=[profile?]
		dev-haskell/syb:=[profile?]
		dev-haskell/text-rope:=[profile?]
	)
	hls_plugins_splice? (
		dev-haskell/aeson:=[profile?]
		dev-haskell/foldl:=[profile?]
		dev-haskell/ghc-exactprint:=[profile?]
		dev-haskell/lens:=[profile?]
		dev-haskell/syb:=[profile?]
	)
	hls_plugins_stylish-haskell? (
		>=dev-haskell/stylish-haskell-0.12:=[profile?] <dev-haskell/stylish-haskell-0.15
	)
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
"
#	test? (
#		# Test deps must be rewritten
#	)

src_configure() {
	config_flags=(
		$(cabal_flag hls_plugins_alternate-number-format alternateNumberFormat)
		$(cabal_flag hls_plugins_cabal cabal)
		$(cabal_flag hls_plugins_cabal-fmt cabalfmt)
		$(cabal_flag hls_plugins_cabal-gild cabalgild)
		$(cabal_flag hls_plugins_call-hierarchy callHierarchy)
		$(cabal_flag hls_plugins_change-type-signature changeTypeSignature)
		$(cabal_flag hls_plugins_class class)
		$(cabal_flag hls_plugins_code-range codeRange)
		$(cabal_flag hls_plugins_eval eval)
		$(cabal_flag hls_plugins_explicit-fields explicitFields)
		$(cabal_flag hls_plugins_explicit-fixity explicitFixity)
		$(cabal_flag hls_plugins_floskell floskell)
		$(cabal_flag hls_plugins_gadt gadt)
		$(cabal_flag hls_plugins_hlint hlint)
		$(cabal_flag hls_plugins_import-lens importLens)
		$(cabal_flag hls_plugins_module-name moduleName)
		$(cabal_flag hls_plugins_notes notes)
		$(cabal_flag hls_plugins_overloaded-record-dot overloadedRecordDot)
		$(cabal_flag hls_plugins_pragmas pragmas)
		$(cabal_flag hls_plugins_qualify-imported-names qualifyImportedNames)
		$(cabal_flag hls_plugins_refactor refactor)
		$(cabal_flag hls_plugins_rename rename)
		$(cabal_flag hls_plugins_retrie retrie)
		$(cabal_flag hls_plugins_semantic-tokens semanticTokens)
		$(cabal_flag hls_plugins_splice splice)
		$(cabal_flag hls_plugins_stylish-haskell stylishhaskell)
		--flag=-fourmolu
		--flag=-ormolu
		--flag=-stan
		--flag=-dynamic
		--flag=ghc-lib
		--flag=ignore-plugins-ghc-bounds
		--flag=-pedantic
		--flag=-isoloateCabalfmtTests
	)

	haskell-cabal_src_configure "${config_flags[@]}"
}

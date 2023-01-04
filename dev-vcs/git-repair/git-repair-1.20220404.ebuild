# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0

CABAL_FEATURES="haddock hoogle profile"
inherit haskell-cabal

DESCRIPTION="repairs a damaged git repository"
HOMEPAGE="https://git-repair.branchable.com/"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

GHC_BOOTSTRAP_PACKAGES=(
	async
	data-default
	filepath-bytestring
	hslogger
	IfElse
	split
	unix-compat
)

RDEPEND="
	dev-haskell/async:=[profile?]
	dev-haskell/attoparsec:=[profile?]
	dev-haskell/data-default:=[profile?]
	>=dev-haskell/filepath-bytestring-1.4.2.1.4:=[profile?]
	dev-haskell/hslogger:=[profile?]
	dev-haskell/ifelse:=[profile?]
	>=dev-haskell/network-2.6:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	>=dev-haskell/optparse-applicative-0.14.1:=[profile?]
	dev-haskell/process:=[profile?]
	dev-haskell/quickcheck:2=[profile?]
	dev-haskell/split:=[profile?]
	>=dev-haskell/unix-compat-0.5:=[profile?]
	dev-haskell/utf8-string:=[profile?]
	>=dev-lang/ghc-8.10.1:=[profile?]
"
DEPEND="
	${RDEPEND}
	>=dev-haskell/cabal-3.2.0.0
"

src_install() {
	haskell-cabal_src_install
	doman git-repair.1
}

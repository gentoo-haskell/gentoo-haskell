# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
CABAL_FEATURES+=" nocabaldep"
inherit eutils git-2 haskell-cabal pax-utils

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
EGIT_REPO_URI="http://darcs.haskell.org/haddock.git https://github.com/ghc/haddock.git"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

# the live ebuild requires alex and happy
RDEPEND="dev-haskell/ghc-paths:=[profile?]
	dev-haskell/haddock-library
	>=dev-haskell/xhtml-3000.2:=[profile?] <dev-haskell/xhtml-3000.3:=[profile?]
	>=dev-lang/ghc-7.9:=
"
DEPEND="${RDEPEND}
	dev-haskell/alex
	dev-haskell/happy
	test? ( dev-haskell/hspec
		>=dev-haskell/quickcheck-2 <dev-haskell/quickcheck-3 )
"

src_prepare() {
	if [[ ! -e "${S}/html" ]]; then
		ln -s resources/html "${S}/html" || die "Could not create symbolic link ${S}/html"
	fi
}

src_configure() {
	# create a fake haddock executable. it'll set the right version to cabal
	# configure, but will eventually get overwritten in src_compile by
	# the real executable.
	local exe="${S}/dist/build/haddock/haddock"
	mkdir -p $(dirname "${exe}")
	local haddock_pv="$(egrep '^version:' ${PN}.cabal | sed -e 's/^version:[ \t]*//')"
	echo -e "#!/bin/sh\necho Haddock version ${haddock_pv}" > "${exe}"
	chmod +x "${exe}"

	# we use 'nocabaldep' to use ghc's bundled Cabal
	# as external one is likely to break our haddock
	# (known to work on 1.16.0 and breaks on 1.16.0.1!)
	haskell-cabal_src_configure \
		--ghc-options=-rtsopts \
		--with-haddock="${exe}" \
		--constraint="Cabal == $(cabal-version)"
}

src_compile() {
	# when building the (recursive..) haddock docs, change the datadir to the
	# current directory, as we're using haddock inplace even if it's built to be
	# installed into the system first.
	haddock_datadir="${S}" haskell-cabal_src_compile
}

src_install() {
	cabal_src_install
	# haddock uses GHC-api to process TH source.
	# TH requires GHCi which needs mmap('rwx') (bug #299709)
	pax-mark -m "${D}/usr/bin/${PN}"
}

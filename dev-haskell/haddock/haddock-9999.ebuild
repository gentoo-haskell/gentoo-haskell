# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit base eutils git-2 haskell-cabal pax-utils

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
EGIT_REPO_URI="http://darcs.haskell.org/haddock.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

# the live ebuild requires alex and happy
RDEPEND="dev-haskell/ghc-paths[profile?]
		=dev-haskell/xhtml-3000.2*[profile?]
		>=dev-lang/ghc-7.5"
DEPEND="${RDEPEND}
		dev-haskell/alex
		dev-haskell/happy
		>=dev-haskell/cabal-1.14"

RESTRICT="test" # avoid depends on QC

CABAL_EXTRA_BUILD_FLAGS="--ghc-options=-rtsopts"

# The bug report http://trac.haskell.org/haddock/ticket/202 still occurs
# with haddock built from git 20120526 building docs for quickcheck-2.5.
# Try patching in a tweaked code fragment from the haddock ghc-7.4 branch.
PATCHES=("${FILESDIR}/${PN}-2.10.0_p20120711-ghc-7.5.patch"
	"${FILESDIR}/${PN}-2.10.0_p20120711-ticket-202.patch")

src_configure() {
	# create a fake haddock executable. it'll set the right version to cabal
	# configure, but will eventually get overwritten in src_compile by
	# the real executable.
	local exe="${S}/dist/build/haddock/haddock"
	mkdir -p $(dirname "${exe}")
	local haddock_pv="$(egrep '^version:' ${PN}.cabal | sed -e 's/^version:[ \t]*//')"
	echo -e "#!/bin/sh\necho Haddock version ${haddock_pv}" > "${exe}"
	chmod +x "${exe}"

	haskell-cabal_src_configure --with-haddock="${exe}"
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

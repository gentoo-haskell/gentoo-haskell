# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit eutils haskell-cabal pax-utils versionator

MY_PV=$(get_version_component_range '1-3')

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
# This is only for ghc head 7.7 and live ebuilds
KEYWORDS=""
IUSE=""

RDEPEND="dev-haskell/ghc-paths[profile?]
		=dev-haskell/xhtml-3000.2*[profile?]
		>=dev-lang/ghc-7.7"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.14"

RESTRICT="test" # avoid depends on QC

S="${WORKDIR}/${PN}-${MY_PV}"

CABAL_EXTRA_BUILD_FLAGS="--ghc-options=-rtsopts"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.10.0_p20120711-ghc-7.5.patch
	# we would like to avoid happy and alex depends
	epatch "${FILESDIR}"/${PN}-2.10.0-drop-tools.patch
	epatch "${FILESDIR}"/${PN}-2.11.0_p20121022-needs-deepseq.patch

	# Its a snapshot of the haddock included with ghc head snapshot, which
	# does not require alex or happy.  The copy of the Lex and Parse files
	# is already done in the tarball.
}

src_configure() {
	# create a fake haddock executable. it'll set the right version to cabal
	# configure, but will eventually get overwritten in src_compile by
	# the real executable.
	local exe="${S}/dist/build/haddock/haddock"
	mkdir -p $(dirname "${exe}")
	echo -e "#!/bin/sh\necho Haddock version ${PV}" > "${exe}"
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

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

# haddock-2.9.4 on hackage does not work with ghc-7.4.
# this ebuild uses a tarball of what's distributed with ghc-7.4.

EAPI="3"

#CABAL_FEATURES="bin lib profile haddock hscolour"
CABAL_FEATURES="bin lib profile hscolour"
inherit haskell-cabal pax-utils

DESCRIPTION="A documentation-generation tool for Haskell libraries"
HOMEPAGE="http://www.haskell.org/haddock/"
#SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~gienah/snapshots/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/ghc-paths
		=dev-haskell/xhtml-3000.2*
		>=dev-lang/ghc-7.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.10"

RESTRICT="test" # avoid depends on QC

# although haddock depends on alex and happy to build from scratch, we don't
# want this ebuild to depend on those packages.
# we use haddock to build the documentation enabled by USE="doc".
# alex and happy only build executables, which does not require haddock.
# however, happy depends on mtl which can be build with USE="doc", which would
# create a circular dependency.
# haddock upstream solved this by bundling preprocessed files.
# unfortunately cabal has recently changed which directory it uses for these
# intermediate files and thus the solution does not work anymore.
# to fix this we move those preprocessed files back to the source tree.

# src_prepare() {
# 	for f in Lex Parse; do
# 		rm "src/Haddock/$f."*
# 		mv "dist/build/haddock/haddock-tmp/Haddock/$f.hs" src/Haddock/
# 	done
# }

# haddock is disabled as Cabal seems to be buggy about building docks with itself.
# however, other packages seem to work
#src_configure() {
#	# create a fake haddock executable. it'll set the right version to cabal
#	# configure, but will eventually get overwritten in src_compile by
#	# the real executable.
#	local exe="${S}/dist/build/haddock/haddock"
#	mkdir -p $(dirname "${exe}")
#	echo -e "#!/bin/sh\necho Haddock version ${PV}" > "${exe}"
#	chmod +x "${exe}"
#
#	haskell-cabal_src_configure --with-haddock="${exe}"
#}
#
#src_compile() {
#	# when building the (recursive..) haddock docs, change the datadir to the
#	# current directory, as we're using haddock inplace even if it's built to be
#	# installed into the system first.
#	haddock_datadir="${S}" haskell-cabal_src_compile
#}

src_install() {
	cabal_src_install
	# haddock uses GHC-api to process TH source.
	# TH requires GHCi which needs mmap('rwx') (bug #299709)
	pax-mark -m "${D}/usr/bin/${PN}"
}

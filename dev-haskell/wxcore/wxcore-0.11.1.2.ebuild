# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit base haskell-cabal ghc-package eutils

DESCRIPTION="wxHaskell core"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/bytestring
		>=dev-haskell/cabal-1.2
		dev-haskell/parsec
		dev-haskell/stm
		dev-haskell/time
		>=x11-libs/wxGTK-2.6"

PATCHES=( "${FILESDIR}/${P}-*.patch" )

src_compile() {
	# does both configure and compile phase
	haskell-cabal_src_compile || die "compile phase failed"

	# must be done after config, can be done after compile
	echo '## Gentoo' >> "${S}"/config/config.mk
	echo 'HCPKGOPT="${HCPKGOPT} --force"' >> "${S}"/config/config.mk
}

src_install() {
	# custom src_install that does parts of haskell-cabal_src_install, but in a
	# slightly different manner, adapter to wxcore

	# 'make install' or 'make copy' would try to register too, so just install
	# the data files. registration will happen in pkg_postinst by eclass
	emake DESTDIR="${D}" wxcore-install-files

	# pick up prepared cabal .pkg file
	ghc-setup-pkg "${S}/config/${PN}.pkg"

	# install .pkg into gentoo/
	ghc-install-pkg
}

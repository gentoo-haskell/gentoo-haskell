# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

DESCRIPTION="A collection of tools for processing XML with Haskell"
HOMEPAGE="http://www.fh-wedel.de/~si/HXmlToolbox/"
SRC_URI="http://www.fh-wedel.de/~si/HXmlToolbox/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	>=dev-haskell/http-2006.7.7
	>=dev-haskell/hunit-1.1
	>=dev-haskell/network-1.0"

src_unpack() {
	unpack "${A}"

	# Oh ffs! The name of the licence file in the cabal file does not match
	# the name of the file in the tarball so it fails at the install step.
	sed -i -e 's/LICENCE/LICENSE/' "${S}/hxt.cabal"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/build-depends:/a \
			, process, containers, directory' \
			"${S}/hxt.cabal"
	fi
}

src_install() {
	cabal_src_install

	dodoc README
	if use doc; then
		cd "${S}/doc"
		dodoc thesis.pdf
	fi
}

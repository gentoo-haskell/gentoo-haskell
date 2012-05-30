# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

CABAL_FEATURES="bin"
inherit haskell-cabal elisp-common darcs

DESCRIPTION="Agda standard library"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
EDARCS_REPOSITORY="http://www.cse.chalmers.se/~nad/repos/lib/"
EDARCS_GET_CMD="get --verbose"
EDARCS_LOCALREPO="Agda2-stdlib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

DEPEND="=sci-mathematics/agda-executable-9999*"
RDEPEND="=sci-mathematics/agda-9999*[profile?]
		=dev-haskell/filemanip-0.3*[profile?]"

SITEFILE="50${PN}-gentoo.el"

S="${WORKDIR}/agda-stdlib-${PV}"

src_prepare() {
	cabal-mksetup
}

src_compile() {
	haskell-cabal_src_compile
	${S}/dist/build/GenerateEverything/GenerateEverything \
		|| die "GenerateEverything failed"
	local prof
	use profile && prof="--ghc-flag=-prof"
	agda +RTS -K1G -RTS ${prof} \
		-i "${S}" -i "${S}"/src "${S}"/Everything.agda || die
	agda --html -i "${S}" -i "${S}"/src "${S}"/README.agda || die
}

src_test() {
	agda -i "${S}" -i "${S}"/src README.agda || die
}

src_install() {
	insinto usr/share/agda-stdlib
	doins -r src/*
	dodoc -r html/*
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}

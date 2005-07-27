# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap"
inherit haskell-cabal eutils base

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/rc/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="doc"

DEPEND=">=virtual/ghc-6.2"

S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack
	epatch ${FILESDIR}/ghcilibs.patch
}

src_compile() {
	make setup
	cabal-configure
	cabal-build

	# This should build the cabal2conf program without rebuilding any of the
	# cabal libs because we look in the dist/build dir for the .hi files and
	# we link with the dist/build/libHSCabal-${PV}.a that has already been
	# built. We're also careful to put the temporary build files in ${TMP} or
	# otherwise ghc would try to write to ${FILESDIR} which is not allowed.
	$(ghc-getghc) ${FILESDIR}/cabal2conf.hs -o ${S}/cabal2conf \
		-odir ${TMP} -hidir ${TMP} \
		-idist/build -Ldist/build -lHSCabal-${PV} \
		|| die "building cabal2conf tool failed"
}

src_install() {
	cabal_src_install

	dosbin ${S}/cabal2conf
	
	# documentation (install directly; generation seems broken to me atm)
	dohtml -r doc/users-guide
	if use doc; then
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}

pkg_postinst () {
	ghc-package_pkg_postinst

	einfo "If you have an older version of Cabal installed, you may have to"
	einfo "specify which version you want when you run ghc.  For instance:"
	einfo ""
	einfo "  $ ghc -package Cabal"
	einfo "ghc-6.4: Error; multiple packages match Cabal: Cabal-1.0, Cabal-${PV}"
	einfo ""
	einfo "If you want to avoid this situation, you can remove the"
	einfo "older version with:"
	einfo ""
	einfo "  $ ghc-pkg unregister Cabal-1.0"
}


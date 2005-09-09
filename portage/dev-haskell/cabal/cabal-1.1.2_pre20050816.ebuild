# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bootstrap"
inherit haskell-cabal ghc-package eutils base

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
#SRC_URI="http://haskell.org/cabal/release/rc/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~kosmikus/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="doc"

# TODO: ghc-6.4 doesn't let us install cabal-1.1.1 correctly. On a clean
# install, the "make setup" call below causes ghc-6.4 to use cabal-1.0 which
# is shipped with ghc-6.4 to build setup. As a result cabal2conf doesn't work
# properly in the end, and probably other things are broken too. The same
# problem might arise in general when new cabal versions are merged while
# older ones are still installed. ghc-6.4 does not provide an easy way to
# hide all Cabal packages. This problem doesn't arise with ghc-6.4.1.
# Should we let cabal-1.1.1 depend on ghc-6.4.1? What about ghc-6.2 and cabal?
DEPEND=">=virtual/ghc-6.2"

MY_PV="${PV/_pre*/}"
S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack

	# Grrr, Cabal build-depends on the util package which is one of the old
	# hslibs packages. Exposing util breaks lots of things. Fortunately cabal
	# doesn't actually use anything fro util so we can remove it. A patch has
	# been sent upstream so remove this hack on the next cabal iteration.
	if $(ghc-cabal); then
		sed -i 's/Build-Depends: base, util/Build-Depends: base/' ${S}/Cabal.cabal
	else
		sed -i 's/Build-Depends: base, util/Build-Depends: base, unix/' ${S}/Cabal.cabal
	fi
}

src_compile() {
	make setup
	cabal-configure
	cabal-build

	# This should build the cabal2conf program without rebuilding any of the
	# cabal libs because we look in the dist/build dir for the .hi files and
	# we link with the dist/build/libHSCabal-${MY_PV}.a that has already been
	# built. We're also careful to put the temporary build files in ${TMP} or
	# otherwise ghc would try to write to ${FILESDIR} which is not allowed.
	$(ghc-getghc) ${FILESDIR}/cabal2conf.hs -o ${S}/cabal2conf \
		-odir ${TMP} -hidir ${TMP} \
		-idist/build -Ldist/build -lHSCabal-${MY_PV} -package unix \
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
	einfo "  ghc-6.4: Error; multiple packages match Cabal: Cabal-1.0, Cabal-${MY_PV}"
	einfo ""
	einfo "If you want to avoid this situation, you can remove the"
	einfo "older version with:"
	einfo ""
	einfo "  $ ghc-pkg unregister Cabal-1.0"
}


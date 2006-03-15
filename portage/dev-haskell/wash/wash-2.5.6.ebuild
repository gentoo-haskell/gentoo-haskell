# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wash/wash-2.5.6.ebuild,v 1.2 2006/03/11 11:51:49 dcoutts Exp $

inherit base ghc-package check-reqs

# the installation bundle is called WashNGo
MY_PN="WashNGo"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WASH is a family of embedded domain-specific languages for programming Web applications"
HOMEPAGE="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/"
SRC_URI="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="doc postgres"

RDEPEND=">=virtual/ghc-6.4.1
		postgres? ( >=dev-db/libpq-7.4.3 )"

DEPEND="${RDEPEND}
		postgres? ( >=dev-haskell/c2hs-0.14.0 )
		doc? ( dev-haskell/haddock )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# There are a couple Wash modules which take forever to compile and
	# cause ghc take loads of memory. We try and limit ghc's heap size
	# but it still takes a lot.
	einfo "Some Wash modules take a lot of RAM and a very long time to compile."
	# We need aproximately this much memory: (does *not* check swap)
	case "${ARCH}" in
		alpha|*64) CHECKREQS_MEMORY="400" ;;
		*)         CHECKREQS_MEMORY="200" ;;
	esac
	check_reqs
}

src_unpack() {
	base_src_unpack

	# don't use -O2 in HCFLAGS because it makes ghc take 700Mb of RAM
	sed -i 's/-O2/-O/' \
		"${S}/lib/WASH/Utility/Makefile" \
		"${S}/lib/Makefile.HTML" \
		"${S}/lib/Makefile.Mail" \
		"${S}/lib/Makefile.Dbconnect" \
		"${S}/lib/Makefile.Utility" \
		"${S}/lib/Makefile.CGI"
}

src_compile() {
	# Wash doesn't know how to use c2hs properly so we have to fix it.
	if use postgres; then
		# make it import a local copy of the C2HS module
		pushd ${S}/lib/WASH/Dbconnect
		c2hs --copy-library
		popd
		sed -i 's/C2HS/WASH.Dbconnect.C2HS/' \
			"${S}/lib/WASH/Dbconnect/C2HS.hs" \
			"${S}/lib/WASH/Dbconnect/Libpqfe.chs"
		# make it not use the (non-existant) c2hs package
		sed -i 's/-package c2hs//' \
			"${S}/lib/Makefile.Dbconnect"
		# add the local C2HS module to the hidden-modules
		sed -i 's/DBCONNECT_HIDDEN=/DBCONNECT_HIDDEN= C2HS/' \
			"${S}/lib/modules.mk"
		# remove unecessary ld options
		sed -i 's/$(EXTRA_LD_OPTS)//' "${S}/lib/Makefile"
	fi
	# Wash doesn't need to directly depend on the rts package
	# it doesn't want the text package, it wants the parsec package
	# there is no c2hs package!
	sed -i -e 's/rts//' -e 's/text/parsec/' -e 's/c2hs//' "${S}/lib/Makefile"

	./configure \
		--prefix="/usr" \
		--libdir="/usr/$(get_libdir)/${P}" \
		$(use_enable postgres dbconnect) \
		$(use_enable doc build-docs) \
		--with-hc=$(ghc-getghc) \
		--with-hcflags="+RTS -M${CHECKREQS_MEMORY}m -RTS" \
		--enable-register-package="${S}/$(ghc-localpkgconf)" \
		|| die "configure failed"
	make all || die "make all failed"
}

src_install() {
	ghc-setup-pkg
	make prefix="${D}/usr" \
		 PACKAGELIBDIR="${D}/usr/$(get_libdir)/${P}/ghc-$(ghc-version)" \
		 install \
		|| die "make install failed"
	ghc-install-pkg

	# We really don't need the GenPKG program, it's an internal Wash thing.
	# I see no reason for it to be installed.
	rm -f "${D}/usr/bin/GenPKG"

	dodoc README
	if use doc; then
		cp -r Examples ${D}/usr/share/doc/${PF}
		cd doc
		dohtml -r *
	fi
}

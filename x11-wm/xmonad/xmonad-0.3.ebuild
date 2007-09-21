# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit eutils haskell-cabal savedconfig

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz
	extensions? ( http://www.xmonad.org/XMonadContrib-${PV}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extensions savedconfig"

DEPEND=">=dev-haskell/mtl-1.0
	>=dev-haskell/x11-1.2.1
	>=dev-haskell/x11-extras-0.3
	>=dev-lang/ghc-6.6
	extensions? ( >=sys-libs/readline-1.0 )"
RDEPEND="${DEPEND}"

RESTRICT="strip"

SAVED_CONFIG="${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${PF}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use extensions ; then
		mv "${WORKDIR}/XMonadContrib" "${S}"
		epatch "${FILESDIR}/cabal-extensions.patch"
	fi

	use savedconfig && restore_config Config.hs

	if use extensions && use !savedconfig ; then
		epatch "${FILESDIR}/config-extensions.patch"
	fi
}

src_install() {
	cabal_src_install

	echo -e "#!/bin/sh\n/usr/bin/xmonad" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	runhaskell util/GenerateManpage.hs
	doman man/xmonad.1
	insinto /usr/share/${PN}
	newins Config.hs ${PF}.Config.hs
	save_config Config.hs
}

pkg_postinst() {
	if use extensions ; then
		elog "To enable extensions, uncomment the corresponding import statements in"
		elog "${SAVED_CONFIG}, and for some"
		elog "extensions you may also want to uncomment any corresponding key and mouse"
		elog "bindings."
		elog
		elog "For example, for the SimpleDate extension you would search the config file"
		elog "for all instances of the string \"SimpleDate\" and follow any commented"
		elog "instructions for each -- in this case, you would simply need to uncomment the"
		elog "following lines:"
		elog
		elog "  --import XMonadContrib.SimpleDate"
		elog "  -- , ((modMask,               xK_d     ), date)"
		elog
		elog "by removing \"--\" from the beginning of each."
		elog
		elog "Afterwards, re-emerge this package with USE=\"savedconfig\". To force the new"
		elog "configuration to take effect in a running xmonad session press <Mod>-q."
	fi
}

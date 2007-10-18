# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CABAL_FEATURES="bin"

inherit haskell-cabal darcs savedconfig

DESCRIPTION="A lightweight X11 window manager"
HOMEPAGE="http://www.xmonad.org/"
EDARCS_REPOSITORY="http://code.haskell.org/xmonad"
XMONAD_REPOSITORY="${EDARCS_TOP_DIR}/xmonad"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="savedconfig extensions"

DEPEND=">=dev-haskell/mtl-1.0
	>=dev-haskell/x11-1.2.3
	dev-haskell/x11-extras-darcs
	>=dev-lang/ghc-6.6"
RDEPEND="${DEPEND}"

RESTRICT="strip"

SAVED_CONFIG="${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${PF}"

fetch_XMonadContrib() {
	local EDARCS_REPOSITORY EDARCS_LOCALREPO
	EDARCS_REPOSITORY="http://code.haskell.org/XMonadContrib"
	EDARCS_LOCALREPO="xmonad/XMonadContrib"
	darcs_fetch
}

delete_XMonadContrib() {
	if [ -d "${XMONAD_REPOSITORY}/XMonadContrib" ]; then
		rm -rf "${XMONAD_REPOSITORY}/XMonadContrib"
	fi
}

src_unpack() {
	darcs_src_unpack

	if use extensions ; then
		fetch_XMonadContrib
		sh "${S}/XMonadContrib/scripts/generate-configs" --main "${S}" \
			--contrib "${S}/XMonadContrib" || die "generate-configs failed"
		mv -f "${S}/XMonadContrib/xmonad.cabal" "${S}"
	else
		delete_XMonadContrib
	fi

	cd "${S}"

	use savedconfig && restore_config Config.hs

	if use extensions && use !savedconfig ; then
		mv -f XMonadContrib/Config.hs "${S}"
	fi
}

src_install() {
	cabal_src_install

	mv "${D}/usr/bin/xmonad"{,-darcs}

	echo -e "#!/bin/sh\n/usr/bin/xmonad-darcs" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	runhaskell util/GenerateManpage.hs
	mv man/xmonad{,-darcs}.1
	doman man/xmonad-darcs.1

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

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit font

MY_PN="Hasklig"
DESCRIPTION="Hasklig - a Haskell code font with monospaced ligatures"
HOMEPAGE="https://github.com/i-tu/Hasklig"
SRC_URI="https://github.com/i-tu/Hasklig/releases/download/v${PV}/${MY_PN}-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

S="${WORKDIR}"

# There are also ttf fonts but I've googled that otf is better
FONT_SUFFIX="otf"
FONT_S="${S}/OTF"

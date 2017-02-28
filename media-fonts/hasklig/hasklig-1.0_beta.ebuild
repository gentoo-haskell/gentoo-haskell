# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5
inherit font

MY_PN="Hasklig"
DESCRIPTION="Hasklig - a Haskell code font with monospaced ligatures"
HOMEPAGE="https://github.com/i-tu/Hasklig"
SRC_URI="https://github.com/i-tu/Hasklig/releases/download/v1.0-beta/${MY_PN}-1.0-Beta.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

S=${WORKDIR}

FONT_SUFFIX="otf"
FONT_S=${S}

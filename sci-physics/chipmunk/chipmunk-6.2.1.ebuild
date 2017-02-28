# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils versionator

MY_PN=Chipmunk
MAJOR=$(get_major_version)
MY_P=${MY_PN}-${PV}

DESCRIPTION="simple, lightweight, fast and portable 2D rigid body physics library"
HOMEPAGE="http://chipmunk-physics.net/"
SRC_URI="http://chipmunk-physics.net/release/${MY_PN}-${MAJOR}.x/${MY_P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/glew
	media-libs/glfw
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

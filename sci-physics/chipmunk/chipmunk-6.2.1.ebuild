# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils versionator

MY_PN=Chipmunk
MAJOR=$(get_major_version)
MY_P=${MY_PN}-${PV}

DESCRIPTION="Chipmunk2D is a simple, lightweight, fast and portable 2D rigid body physics library written in C"
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

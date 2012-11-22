# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="A purely functional package manager"
HOMEPAGE="http://nixos.org/nix"

#in case we have something like _pre15214
MY_PV="${PV/_/}"

SRC_URI="http://hydra.nixos.org/build/2860022/download/4/${PN}-${MY_PV}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

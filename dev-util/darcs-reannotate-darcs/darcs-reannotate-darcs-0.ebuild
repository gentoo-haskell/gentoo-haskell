# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

DESCRIPTION="Reformats \"darcs annotate\" output to look more like \"cvs annotate\"."
HOMEPAGE="http://darcs.net/DarcsWiki/DarcsReannotate"
LICENSE="BSD" #unknown license..
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/python"

EDARCS_REPOSITORY="http://cakoose.com/darcs/darcs-reannotate/"
EDARCS_GET_CMD="get --partial"

src_install() {
	dobin darcs-reannotate
}

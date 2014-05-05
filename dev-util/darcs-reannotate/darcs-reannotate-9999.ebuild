# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit darcs

DESCRIPTION="Reformats \"darcs annotate\" output to look more like \"cvs annotate\"."
HOMEPAGE="http://darcs.net/DarcsWiki/DarcsReannotate"
LICENSE="freedist" # not mentioned
SLOT="0"

KEYWORDS=""

IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

EDARCS_REPOSITORY="http://cakoose.com/darcs/darcs-reannotate/"

src_install() {
	dobin darcs-reannotate
}

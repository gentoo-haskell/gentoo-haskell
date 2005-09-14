# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# much ist copied from cvs.eclass

# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# This ebuild

inherit darcs

DESCRIPTION="jhc new experimental ebuild for experimental HASKELL compiler ;)"
HOMEPAGE="http://repetae.net/john/computer/jhc/"

#LICENSE="don't know"
# google groups mail said gpl..
SLOT="0"
KEYWORDS="~x86"
IUSE=""

EDARCS_REPOSITORY="http://repetae.net/john/repos/jhc"
EDARCS_GET_CMD="get --partial"

# I had this darcs version
# drift is also needed!
DEPEND="
	>=dev-util/darcs-1.0.2
	>=dev-haskell/drift-2.1.1" 
# RDEPEND=""

# this functions checks wether the repository should be updated or downloaded
# from scratch
# $1 is reposititory $2 is directory from which to call darcs pull
download-darcs-repo() {
	EDARCS_REPOSITORY="$1" EDARCS_LOCALREPO="$2" darcs_fetch
}

src_unpack() {
	download-darcs-repo http://repetae.net/john/repos/jhc jhc
	download-darcs-repo http://repetae.net/john/repos/Boolean jhc/Boolean || die  "Boolean couldn\'t be downloaded"
	download-darcs-repo http://repetae.net/john/repos/Doc jhc/Doc || die "Doc couldn\'t be downloaded"
	darcs_src_unpack
}

src_compile() {
	make || die "making jhc failed"
}


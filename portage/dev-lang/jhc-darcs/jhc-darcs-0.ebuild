# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# much ist copied from cvs.eclass

# !!!!!!!!!!!!!!!!!!!!!!!!!!!
# This ebuild

DESCRIPTION="jhc new experimental ebuild for experimental HASKELL compiler ;)"
HOMEPAGE="http://repetae.net/john/computer/jhc/"

#LICENSE="don't know"
# google groups mail said gpl..
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# we use darcs, so don't try to fetch anything. We'll do that by ourselfs
RESTRICT="fetch"

# I had this darcs version
# drift is also needed!
DEPEND="
	>=dev-util/darcs-1.0.2
	>=dev-haskell/drift-2.1.1" 
# RDEPEND=""

# this functions checks wether the repository should be updated or downloaded
# from scratch
# $1 is reposititory $2 is directory from which to call darcs pull
downloadRep() {

if [ -d $2 ]; then
	einfo "updating repository $1"
	cd $2
	darcs pull
	cd ..
else
	einfo "downloading repository $1"
	darcs get $1
fi
}

pkg_nofetch() {
	einfo "no fetch!"
	}

src_unpack() {
	ewarn " This ebuild does only compile jhc by now !!! It dosn't install
	anything. feel free to modify... I don't know yet how to install the libs.
	It would be best to compile them before isntalling "
	# >>> set temp fetch direcotry (similar to cvs.eclass)
		[ -z "$EDARCS_TOP_DIR" ] && EDARCS_TOP_DIR="${DISTDIR}/darcs-src"

		# Create the top dir if needed

		if [ ! -d "$EDARCS_TOP_DIR" ]; then

			einfo "creating EDARCS_TOP_DIR $EDARCS_TOP_DIR"
			addwrite /foobar
			addwrite /
			mkdir -p "$EDARCS_TOP_DIR" | die "couldnt create top dir"
			export SANDBOX_WRITE="${SANDBOX_WRITE//:\/foobar:\/}"
		else
			einfo "using EDARCS_TOP_DIR $EDARCS_TOP_DIR"
		fi

		# In case EDARCS_TOP_DIR is a symlink to a dir, get the real path,
		# otherwise addwrite() doesn't work.

		cd -P "$EDARCS_TOP_DIR" || die "Couldn't change directory to EDARS_TOP_DIR!"
		EDARCS_TOP_DIR="`/bin/pwd`"

		# Disable the sandbox for this dir
		 addwrite "$EDARCS_TOP_DIR"

		# Chown the directory and all of its contents
		if [ -n "$EDARCS_RUNAS" ]; then
			chown -R "$EDARCS_RUNAS" "/$EDARCS_TOP_DIR"
		fi
	# <<< end of setting darcs fetch directory


	# create jhc directory:
	cd $EDARCS_TOP_DIR
	[ ! -d jhc-src ] && mkdir jhc-src
	cd jhc-src || die "couldn't cd to jhc-src"
	einfo "I'm downloading source via darcs into " `pwd`

	# update (darcs should have created a _darcs dir) or create? 
	downloadRep http://repetae.net/john/repos/jhc jhc
	cd jhc || die "getting $reporoot should have created a directory jhc, but there is none" rm -fr jhc
	downloadRep http://repetae.net/john/repos/Boolean Boolean || die  "Boolean couldn\'t be downloaded"
	downloadRep http://repetae.net/john/repos/Doc Doc || die "Doc couldn\'t be downloaded"
	einfo "copying files to workdir"
	cd ${EDARCS_TOP_DIR}
	cp -r jhc-src/jhc ${WORKDIR} || die "copying to workdir failed"
	}

src_compile() {
	cd ${WORKDIR}/jhc
	make || die "making jhc failed"
}


# Copyright 2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/darcs.eclass,v 1.3 2006/12/18 11:51:06 kosmikus Exp $
#
# darcs eclass author:  Andres Loeh <kosmikus@gentoo.org>
# tla eclass author:    <rphillips@gentoo.org>
# Original Author:      Jeffrey Yasskin <jyasskin@mail.utexas.edu>
#
# Originally derived from the tla eclass, which is derived from the
# cvs eclass.
#
# This eclass provides the generic darcs fetching functions.
# to use from an ebuild, set the 'ebuild-configurable settings' below in your
# ebuild before inheriting.  then either leave the default src_unpack or extend
# over darcs_src_unpack.

# Most of the time, you will define only $EDARCS_REPOSITORY in your
# ebuild.

# TODO: support for tags, ...

# Don't download anything other than the darcs repository
SRC_URI=""

# You shouldn't change these settings yourself! The ebuild/eclass inheriting
# this eclass will take care of that.

# --- begin ebuild-configurable settings

# darcs command to run
[ -z "$EDARCS_DARCS_CMD" ] && EDARCS_DARCS_CMD="darcs"

# darcs commands with command-specific options
[ -z "$EDARCS_GET_CMD" ] && EDARCS_GET_CMD="get --partial"
[ -z "$EDARCS_UPDATE_CMD" ] && EDARCS_UPDATE_CMD="pull"

# options to pass to both the "get" and "update" commands
[ -z "$EDARCS_OPTIONS" ] && EDARCS_OPTIONS="--set-scripts-executable"

# Where the darcs repositories are stored/accessed
[ -z "$EDARCS_TOP_DIR" ] && EDARCS_TOP_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/darcs-src"

# The URI to the repository.
[ -z "$EDARCS_REPOSITORY" ] && EDARCS_REPOSITORY=""

# The local directory to store the repository (useful to ensure a
# unique local name); relative to EDARCS_TOP_DIR
[ -z "$EDARCS_LOCALREPO" ] && [ -n "$EDARCS_REPOSITORY" ] \
	&& EDARCS_LOCALREPO=${EDARCS_REPOSITORY%/} \
	&& EDARCS_LOCALREPO=${EDARCS_LOCALREPO##*/}

# EDARCS_CLEAN: set this to something to get a clean copy when updating
# (removes the working directory, then uses $EDARCS_GET_CMD to
# re-download it.)

# --- end ebuild-configurable settings ---

# add darcs to deps
DEPEND="dev-util/darcs"

# is called from darcs_src_unpack
darcs_fetch() {

	debug-print-function $FUNCNAME $*

	if [ -n "$EDARCS_CLEAN" ]; then
		rm -rf $EDARCS_TOP_DIR/$EDARCS_LOCALREPO
	fi

	# create the top dir if needed
	if [ ! -d "$EDARCS_TOP_DIR" ]; then
		# note that the addwrite statements in this block are only there to allow creating EDARCS_TOP_DIR;
		# we've already allowed writing inside it
		# this is because it's simpler than trying to find out the parent path of the directory, which
		# would need to be the real path and not a symlink for things to work (so we can't just remove
		# the last path element in the string)
		debug-print "$FUNCNAME: checkout mode. creating darcs directory"
		addwrite /foobar
		addwrite /
		mkdir -p "$EDARCS_TOP_DIR"
		export SANDBOX_WRITE="${SANDBOX_WRITE//:\/foobar:\/}"
	fi

	# in case EDARCS_DARCS_DIR is a symlink to a dir, get the real
	# dir's path, otherwise addwrite() doesn't work.
	pushd .
	cd -P "$EDARCS_TOP_DIR" > /dev/null
	EDARCS_TOP_DIR="`/bin/pwd`"

	# disable the sandbox for this dir
	addwrite "$EDARCS_TOP_DIR"

	# determine checkout or update mode and change to the right directory.
	if [ ! -d "$EDARCS_TOP_DIR/$EDARCS_LOCALREPO/_darcs" ]; then
		mode=get
		cd "$EDARCS_TOP_DIR"
	else
		mode=update
		cd "$EDARCS_TOP_DIR/$EDARCS_LOCALREPO"
	fi

	# commands to run
	local cmdget="${EDARCS_DARCS_CMD} ${EDARCS_GET_CMD} ${EDARCS_OPTIONS} --repo-name=${EDARCS_LOCALREPO} ${EDARCS_REPOSITORY}"
	local cmdupdate="${EDARCS_DARCS_CMD} ${EDARCS_UPDATE_CMD} --all ${EDARCS_OPTIONS} ${EDARCS_REPOSITORY}"

	if [ "${mode}" == "get" ]; then
		einfo "Running $cmdget"
		eval $cmdget || die "darcs get command failed"
	elif [ "${mode}" == "update" ]; then
		einfo "Running $cmdupdate"
		eval $cmdupdate || die "darcs update command failed"
	fi

	popd
}


darcs_src_unpack() {
	local EDARCS_SHOPT

	debug-print-function $FUNCNAME $*

	debug-print "$FUNCNAME: init:
	EDARCS_DARCS_CMD=$EDARCS_DARCS_CMD
	EDARCS_GET_CMD=$EDARCS_GET_CMD
	EDARCS_UPDATE_CMD=$EDARCS_UPDATE_CMD
	EDARCS_OPTIONS=$EDARCS_OPTIONS
	EDARCS_TOP_DIR=$EDARCS_TOP_DIR
	EDARCS_REPOSITORY=$EDARCS_REPOSITORY
	EDARCS_LOCALREPO=$EDARCS_LOCALREPO
	EDARCS_CLEAN=$EDARCS_CLEAN"

	einfo "Fetching darcs repository $EDARCS_REPOSITORY into $EDARCS_TOP_DIR..."
	darcs_fetch

	einfo "Copying $EDARCS_LOCALREPO from $EDARCS_TOP_DIR..."
	debug-print "Copying $EDARCS_LOCALREPO from $EDARCS_TOP_DIR..."

	# probably redundant, but best to make sure
	# Use ${WORKDIR}/${P} rather than ${S} so user can point ${S} to something inside.
	mkdir -p "${WORKDIR}/${P}"

	EDARCS_SHOPT=$(shopt -p dotglob)
	shopt -s dotglob	# get any dotfiles too.
	cp -Rf "$EDARCS_TOP_DIR/$EDARCS_LOCALREPO"/* "${WORKDIR}/${P}"
	eval ${EDARCS_SHOPT}    # reset shopt

	einfo "Darcs repository contents are now in ${WORKDIR}/${P}"

}

EXPORT_FUNCTIONS src_unpack

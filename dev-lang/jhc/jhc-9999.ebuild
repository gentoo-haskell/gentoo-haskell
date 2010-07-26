# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs autotools

DESCRIPTION="jhc new experimental ebuild for experimental HASKELL compiler ;)"
HOMEPAGE="http://repetae.net/john/computer/jhc/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EDARCS_REPOSITORY="http://repetae.net/john/repos/jhc"
EDARCS_GET_CMD="get --partial"

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/drift-2.1.1
		dev-haskell/happy
		dev-haskell/binary
		dev-haskell/zlib
		virtual/libiconv"
RDEPEND=""

# this functions checks wether the repository should be updated or downloaded
# from scratch
# $1 is reposititory $2 is directory from which to call darcs pull
download-darcs-repo() {
	EDARCS_REPOSITORY="$1" EDARCS_LOCALREPO="$2" darcs_fetch || die "$2 couldn\'t be downloaded"
}

src_unpack() {
	download-darcs-repo http://repetae.net/john/repos/jhc jhc
	download-darcs-repo http://repetae.net/john/repos/Doc jhc/src/Doc
	download-darcs-repo http://darcs.haskell.org/packages/haskell98 jhc/lib/haskell98
	download-darcs-repo http://darcs.haskell.org/packages/containers jhc/lib/containers
	darcs_src_unpack

	einfo "sed containers-0.2.0.hl out as jhc could not build them (2010-03-28)"
	sed -i "${S}/Makefile.am" -e 's/containers-0.2.0.hl/\# &/'

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf || die "econf failed"
	darcs init # workaround missing history

	# (UTF-8 source breaks DrIFT. workaround DrIFT bug)
	cd "${S}/src/E/"
	mv TypeCheck.hs TypeCheck.hs.UTF-8
	iconv -f UTF-8 -t ASCII -c TypeCheck.hs.UTF-8 > TypeCheck.hs || die "unable to recode TypeCheck.hs to ASCII"

	cd "${S}"
	emake jhc || die "'emake jhc' failed"
	emake libs || die "'emake libs' failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}

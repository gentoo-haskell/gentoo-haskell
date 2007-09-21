# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit darcs

DESCRIPTION="jhc new experimental ebuild for experimental HASKELL compiler ;)"
HOMEPAGE="http://repetae.net/john/computer/jhc/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EDARCS_REPOSITORY="http://repetae.net/john/repos/jhc"
EDARCS_GET_CMD="get --partial"

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/drift-2.1.1
		dev-haskell/happy"
RDEPEND=""

JHCPATH="/usr/lib/${PF}"

# this functions checks wether the repository should be updated or downloaded
# from scratch
# $1 is reposititory $2 is directory from which to call darcs pull
download-darcs-repo() {
	EDARCS_REPOSITORY="$1" EDARCS_LOCALREPO="$2" darcs_fetch
}

jhc-remove-libs() {
	local f
	for f in "$@"; do
		rm -f "lib/${f//.//}.hs" "lib/${f/.//}.hs" "lib/${f}.hs"
	done
}

src_unpack() {
	download-darcs-repo http://repetae.net/john/repos/jhc jhc
	download-darcs-repo http://repetae.net/john/repos/Boolean jhc/Boolean || die  "Boolean couldn\'t be downloaded"
	download-darcs-repo http://repetae.net/john/repos/Doc jhc/Doc || die "Doc couldn\'t be downloaded"
	darcs_src_unpack
}

src_compile() {
	make || die "making jhc failed"
	einfo "Removing currently broken libraries ..."
	jhc-remove-libs \
		Data.Bits Test.QuickCheck.Batch Data.Unicode System.Console.GetOpt Data.Dynamic Time Data.Typeable \
		Foreign.C.OldString Jhc.Array Directory Complex Prelude.Ratio
	einfo "Pre-compiling libraries (this can take a while) ..."
	find lib -name \*.hs | sed -e 's|^lib/|import |' -e 's|.hs$||' -e 's|/|.|g' > Lib.hs
	echo 'main = return () :: IO ()' >> Lib.hs
	./jhc -i lib -o Lib -v Lib.hs || die "compiling libraries failed"
	einfo "Creating wrapper script ..."
	echo '#!/bin/bash' > ./jhc.sh
	echo '[[ -z $JHCPATH ]] && export JHCPATH='"${JHCPATH}/lib" >> ./jhc.sh
	echo "${JHCPATH}/bin/jhc"' $*' >> ./jhc.sh
}

src_install() {
	newbin jhc.sh jhc
	into ${JHCPATH}
	insinto ${JHCPATH}
	dobin jhc
	doins -r lib
}


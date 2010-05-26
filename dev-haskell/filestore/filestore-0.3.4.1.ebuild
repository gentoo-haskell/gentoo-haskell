# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Interface for versioning file stores."
HOMEPAGE="http://johnmacfarlane.net/repos/filestore"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

HASKELLDEPS="dev-haskell/datetime
		dev-haskell/diff
		=dev-haskell/parsec-2*
		dev-haskell/split
		dev-haskell/time
		dev-haskell/utf8-string
		dev-haskell/xml"
RDEPEND=">=dev-lang/ghc-6.8.1
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"

pkg_postinst() {
	ghc-package_pkg_postinst

	elog "${PN} requires either dev-vcs/darcs or dev-vcs/git to work."
	elog "Please install one of these DVCS packages to fully utilise ${PN}."
	elog "(These aren't in RDEPEND in case you are just using filestore to program.)"
}

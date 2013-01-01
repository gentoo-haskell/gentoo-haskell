# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="profile haddock lib bin"
inherit haskell-cabal check-reqs

MY_PN="WashNGo"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WASH is a family of embedded domain specific languages for programming Web applications in Haskell."
HOMEPAGE="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/"
SRC_URI="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		dev-haskell/regex-compat"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# There are a couple Wash modules which take forever to compile and
	# cause ghc take loads of memory. We try and limit ghc's heap size
	# but it still takes a lot.
	einfo "Some Wash modules take a lot of RAM and a very long time to compile."
	einfo "Please be patient."
	# We need aproximately this much memory: (does *not* check swap)
	case "${ARCH}" in
		alpha|*64) CHECKREQS_MEMORY="600" ;;
		*)         CHECKREQS_MEMORY="300" ;;
	esac
	check_reqs
}

src_unpack() {
	unpack ${A}

	cabal-mksetup
	sed -i -e "/Extensions/aGhc-Options: -O +RTS -M${CHECKREQS_MEMORY}m -RTS" \
		"${S}/WASH.cabal"
	echo "Ghc-Options: -O +RTS -M${CHECKREQS_MEMORY}m -RTS" \
		>> "${S}/WASH.cabal"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			,containers' \
		"${S}/WASH.cabal"
	fi
}

src_install() {
	cabal_src_install

	dodoc README
	if use doc; then
		dodoc Examples
	fi
}

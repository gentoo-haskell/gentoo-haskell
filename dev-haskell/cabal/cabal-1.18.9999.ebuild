# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bootstrap lib profile test-suite"
CABAL_FEATURES+=" bootstrap" # does not beed cabal to build itself
inherit haskell-cabal eutils

if [[ ${PV} == *9999* ]]; then
	LIVE_EBUILD=yes
	inherit git-2
fi

MY_PN="Cabal"

DESCRIPTION="A framework for packaging Haskell software"
HOMEPAGE="http://www.haskell.org/cabal/"
EGIT_REPO_URI="git://github.com/haskell/cabal.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="doc"

if [[ -n ${LIVE_EBUILD} ]]; then
	# Cabal's subdir
	EGIT_SOURCEDIR=${S}
	S="${S}"/${MY_PN}
else
	SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
	S="${WORKDIR}/${MY_PN}"
fi

RDEPEND=">=dev-lang/ghc-6.12.1:="
DEPEND="${RDEPEND}
	test? ( dev-haskell/extensible-exceptions
		dev-haskell/hunit
		>=dev-haskell/quickcheck-2.1.0.1
		dev-haskell/regex-posix
		dev-haskell/test-framework
		dev-haskell/test-framework-hunit
		>=dev-haskell/test-framework-quickcheck2-0.2.12 )
"

src_prepare() {
	local cabal_upstream_version=$(sed -n 's/^version: //ip' ${MY_PN}.cabal)

	if [[ -n ${LIVE_EBUILD} ]]; then
		# one of renaming reasons is to avoid clashing with bundled ghc-cabal
		CABAL_FILE=${MY_PN}.cabal cabal_chdeps "version: ${cabal_upstream_version}" "version: ${PV}"
	fi
}

src_configure() {
	cabal-is-dummy-lib && return

	einfo "Bootstrapping Cabal..."
	$(ghc-getghc) ${HCFLAGS} -i -i. -i"${WORKDIR}/${FP_P}" -cpp --make Setup.hs \
		-o setup || die "compiling Setup.hs failed"
	cabal-configure
}

src_compile() {
	cabal-is-dummy-lib && return

	cabal-build
}

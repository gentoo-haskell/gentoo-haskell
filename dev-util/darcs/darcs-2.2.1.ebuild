# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib haddock"
inherit haskell-cabal eutils bash-completion

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://darcs.net"
SRC_URI="http://hackage.haskell.org/packages/archive/darcs/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=net-misc/curl-7.10.2
	>=dev-lang/ghc-6.2.2
	>=dev-haskell/cabal-1.6
	=dev-haskell/quickcheck-1*
	dev-haskell/bytestring
	dev-haskell/mtl
	dev-haskell/html
	dev-haskell/http
	=dev-haskell/parsec-2.1*
	dev-haskell/regex-compat
	sys-apps/diffutils
	dev-haskell/network
	dev-haskell/filepath
	doc?  ( virtual/latex-base
		>=dev-tex/latex2html-2002.2.1_pre20041025-r1 )"

RDEPEND=">=net-misc/curl-7.10.2
	virtual/mta
	dev-libs/gmp"

pkg_setup() {
	if use doc && ! built_with_use -o dev-tex/latex2html png gif; then
		eerror "Building darcs with USE=\"doc\" requires that"
		eerror "dev-tex/latex2html is built with at least one of"
		eerror "USE=\"png\" and USE=\"gif\"."
		die "USE=doc requires dev-tex/latex2html with USE=\"png\" or USE=\"gif\""
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}/tools"
	epatch "${FILESDIR}/${PN}-1.0.9-bashcomp.patch"

	# On ia64 we need to tone down the level of inlining so we don't break some
	# of the low level ghc/gcc interaction gubbins.
	use ia64 && sed -i 's/-funfolding-use-threshold20//' "${S}/GNUmakefile"
}

src_compile() {
	# don't use the haskell zlib package
	# with it, I keep getting this:
	#	darcs failed:  Codec.Compression.Zlib: incorrect data check
	CABAL_CONFIGURE_FLAGS="--flags=-external-zlib"
	cabal_src_compile
}

src_install() {
	cabal_src_install
	dobashcompletion "${S}/tools/darcs_completion" "${PN}"
}

pkg_postinst() {
	ghc-package_pkg_postinst
	bash-completion_pkg_postinst

	ewarn "NOTE: in order for the darcs send command to work properly,"
	ewarn "you must properly configure your mail transport agent to relay"
	ewarn "outgoing mail.  For example, if you are using ssmtp, please edit"
	ewarn "/etc/ssmtp/ssmtp.conf with appropriate values for your site."
}

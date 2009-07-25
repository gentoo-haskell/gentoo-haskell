# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal eutils bash-completion

DESCRIPTION="a distributed, interactive, smart revision control system"
HOMEPAGE="http://darcs.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.6
		=dev-haskell/bytestring-0.9*
		=dev-haskell/filepath-1.1*
		<dev-haskell/hashed-storage-0.4
		<dev-haskell/haskeline-0.7
		=dev-haskell/html-1.0*
		>=dev-haskell/mmap-0.2
		<dev-haskell/mtl-1.2
		dev-haskell/parsec
		>=dev-haskell/zlib-0.5.1
		|| ( =dev-haskell/regex-compat-0.7* =dev-haskell/regex-compat-0.9* )
		=dev-haskell/terminfo-0.3*
		=dev-haskell/utf8-string-0.3*
		>=net-misc/curl-7.19.1
        doc?  ( virtual/latex-base
                >=dev-tex/latex2html-2002.2.1_pre20041025-r1 )"

# darcs also has a library version; we thus need $DEPEND
RDEPEND="${DEPEND}
		virtual/mta"

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

	cd "${S}/contrib"
	epatch "${FILESDIR}/${PN}-1.0.9-bashcomp.patch"

	# On ia64 we need to tone down the level of inlining so we don't break some
	# of the low level ghc/gcc interaction gubbins.
	use ia64 && sed -i 's/-funfolding-use-threshold20//' "${S}/GNUmakefile"
}

src_compile() {
	# try to use haskell zlib for this ebuild. for version 2.2.1 there was no
	# success. see commented code below.
	CABAL_CONFIGURE_FLAGS="--flags=zlib"
	# don't use the haskell zlib package
	# with it, I keep getting this:
	#   darcs failed:  Codec.Compression.Zlib: incorrect data check
	#CABAL_CONFIGURE_FLAGS="--flags=-zlib"

	# Use curl for net stuff to avoid strict version dep on HTTP and network
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=curl --flags=-http"

	# Enable curl pipelining
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=curl-pipelining"

	# No default specified, so set it just in case; external bytestring is OK
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=bytestring"

	# This will be mandatory soon anyway, so set it.
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=utf8-string"

	# Enable color, terminfo, mmap
	CABAL_CONFIGURE_FLAGS="${CABAL_CONFIGURE_FLAGS} --flags=color --flags=terminfo --flags=mmap"
	cabal_src_compile
}

src_install() {
	cabal_src_install
	dobashcompletion "${S}/contrib/darcs_completion" "${PN}"
}

pkg_postinst() {
	ghc-package_pkg_postinst
	bash-completion_pkg_postinst

	ewarn "NOTE: in order for the darcs send command to work properly,"
	ewarn "you must properly configure your mail transport agent to relay"
	ewarn "outgoing mail.  For example, if you are using ssmtp, please edit"
	ewarn "/etc/ssmtp/ssmtp.conf with appropriate values for your site."
}


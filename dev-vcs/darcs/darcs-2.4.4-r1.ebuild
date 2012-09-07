# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/darcs/darcs-2.4.4-r1.ebuild,v 1.16 2012/03/04 14:17:07 gienah Exp $

EAPI="3"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal eutils bash-completion-r1

DESCRIPTION="a distributed, interactive, smart revision control system"
HOMEPAGE="http://darcs.net/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc test"

# Dependency notes:
# 1) Use a cunning trick for hashed-storage, haskeline, regex-compat
#       where the min bound is the lowest version available.
# 2) Do the opposite for zlib: highest not available.
# 3) Prefer curl over HTTP since darcs uses an old version of HTTP.
# 4) Use the same bounds for mmap as hashed-storage.

COMMONDEPS=">=dev-lang/ghc-6.8
		>=dev-haskell/hashed-storage-0.4.13[profile?]
		=dev-haskell/haskeline-0.6*[profile?]
		=dev-haskell/html-1.0*[profile?]
		=dev-haskell/mmap-0.4*[profile?]
		<dev-haskell/mtl-1.2[profile?]
		>=dev-haskell/network-2.2[profile?]
		>=dev-haskell/parsec-2.0[profile?]
		<dev-haskell/regex-compat-0.94[profile?]
		=dev-haskell/terminfo-0.3*[profile?]
		=dev-haskell/utf8-string-0.3*[profile?]
		<dev-haskell/zlib-0.6.0.0[profile?]
		net-misc/curl"

DEPEND="${COMMONDEPS}
		>=dev-haskell/cabal-1.6
		dev-util/pkgconfig
		doc?  ( virtual/latex-base
				dev-tex/latex2html )
		test? ( dev-haskell/test-framework[profile?]
				dev-haskell/test-framework-hunit[profile?]
				dev-haskell/test-framework-quickcheck2[profile?] )
		"

# darcs also has a library version; we thus need $DEPEND
RDEPEND="${COMMONDEPS}
		virtual/mta"

pkg_setup() {
	if use doc && ! built_with_use -o dev-tex/latex2html png gif; then
		eerror "Building darcs with USE=\"doc\" requires that"
		eerror "dev-tex/latex2html is built with at least one of"
		eerror "USE=\"png\" and USE=\"gif\"."
		die "USE=doc requires dev-tex/latex2html with USE=\"png\" or USE=\"gif\""
	fi
}

src_prepare() {
	pushd "contrib"
	epatch "${FILESDIR}/${PN}-1.0.9-bashcomp.patch"
	popd

	epatch "${FILESDIR}/${P}-issue1770-curl_multi_perform-no-running-handles.patch"
	epatch "${FILESDIR}/${P}-tests-emailformat.patch"

	# Loosen dependency on hashed-storage
	sed -i -e "s/hashed-storage == 0.4.13/hashed-storage == 0.4.*/" \
		"${S}/${PN}.cabal" \
		|| die "Could not loosen deps on hashed-storage"

	# Loosen dependency on parsec
	sed -i -e "s/parsec       >= 2.0 && < 3.1/parsec       >= 2.0/" \
		"${S}/${PN}.cabal" \
		|| die "Could not loosen deps on parsec"

	# and on network
	sed -i -e 's/network == 2\.2\.\*/network >= 2.2/' \
		"${S}/${PN}.cabal"

	# hlint tests tend to break on every newly released hlint
	rm "${S}/tests/haskell_policy.sh" || die
	rm "${S}/tests/external.sh" || die # relies on example.com layout bug #392647
}

src_configure() {
	# checking whether ghc supports -threaded flag
	# Beware: http://www.haskell.org/ghc/docs/latest/html/users_guide/options-phases.html#options-linker
	# contains: 'The ability to make a foreign call that does not block all other Haskell threads.'
	# It might have interactivity impact.

	threaded_flag=""
	if $(ghc-getghc) --info | grep "Support SMP" | grep -q "YES"; then
		threaded_flag="--flags=threaded"
		einfo "$P will be built with threads support"
	else
		threaded_flag="--flags=-threaded"
		einfo "$P will be built without threads support"
	fi

	# Use curl for net stuff to avoid strict version dep on HTTP and network
	cabal_src_configure \
		--flags=curl \
		--flags=-http \
		--flags=curl-pipelining \
		--flags=color \
		--flags=terminfo \
		--flags=mmap \
		$threaded_flag \
		$(cabal_flag test)
}

src_test() {
	# run cabal test from haskell-cabal
	haskell-cabal_src_test || die "cabal test failed"

	# run the unit tests (not part of cabal test for some reason...)
	# breaks the cabal abstraction a bit...
	"${S}/dist/build/unit/unit" || die "unit tests failed"
}

src_install() {
	cabal_src_install
	newbashcomp "${S}/contrib/darcs_completion" "${PN}"

	rm "${ED}/usr/bin/unit" 2> /dev/null

	# fixup perms in such an an awkward way
	mv "${ED}/usr/share/man/man1/darcs.1" "${S}/darcs.1" || die "darcs.1 not found"
	doman "${S}/darcs.1" || die "failed to register darcs.1 as a manpage"

	# if tests were enabled, make sure the unit test driver is deleted
	rm -rf "${ED}/usr/bin/unit"
}

pkg_postinst() {
	ghc-package_pkg_postinst

	ewarn "NOTE: in order for the darcs send command to work properly,"
	ewarn "you must properly configure your mail transport agent to relay"
	ewarn "outgoing mail.  For example, if you are using ssmtp, please edit"
	ewarn "${EPREFIX}/etc/ssmtp/ssmtp.conf with appropriate values for your site."
}

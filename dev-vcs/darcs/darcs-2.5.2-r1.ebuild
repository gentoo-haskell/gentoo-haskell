# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/darcs/darcs-2.5.2-r1.ebuild,v 1.3 2012/03/04 14:17:07 gienah Exp $

EAPI="4"
CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal bash-completion-r1

DESCRIPTION="a distributed, interactive, smart revision control system"
HOMEPAGE="http://darcs.net/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc test"

RDEPEND="=dev-haskell/hashed-storage-0.5*[profile?]
		=dev-haskell/haskeline-0.6*[profile?]
		=dev-haskell/html-1.0*[profile?]
		<dev-haskell/http-4000.3[profile?]
		=dev-haskell/mmap-0.5*[profile?]
		<dev-haskell/mtl-2.1[profile?]
		>=dev-haskell/network-2.2[profile?]
		<dev-haskell/parsec-3.2[profile?]
		<dev-haskell/regex-compat-0.96[profile?]
		=dev-haskell/tar-0.3*[profile?]
		=dev-haskell/terminfo-0.3*[profile?]
		=dev-haskell/text-0.11*[profile?]
		<dev-haskell/zlib-0.6.0.0[profile?]
		>=dev-lang/ghc-6.10.1
		net-misc/curl
		virtual/mta"

# darcs also has a library version; we thus need $DEPEND
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		doc? ( virtual/latex-base
			|| (	dev-tex/latex2html[png]
				dev-tex/latex2html[gif]
			)
		)
		test? ( dev-haskell/test-framework[profile?]
				dev-haskell/test-framework-hunit[profile?]
				dev-haskell/test-framework-quickcheck2[profile?]
		)
		"

src_prepare() {
	cd "${S}/contrib"
	epatch "${FILESDIR}/${PN}-1.0.9-bashcomp.patch"
	cd ..

	epatch "${FILESDIR}/${PN}-2.5.2-relax-regex-libs-deps.patch"
	epatch "${FILESDIR}/${PN}-2.5.2-ghc-7.2.patch"
	epatch "${FILESDIR}/${PN}-2.5.2-tests-ghc-7.2.patch"
	epatch "${FILESDIR}/${PN}-2.5.2-relax-http-libs-deps.patch"
	epatch "${FILESDIR}/${PN}-2.5.2-ghc-7.4.patch"

	# hlint tests tend to break on every newly released hlint
	rm "${S}/tests/haskell_policy.sh"
	rm "${S}/tests/external.sh" || die # relies on example.com layout bug #392647

	# use a more recent API, and thus depend on a more recent package
	sed -i -e "s/findBy/find/" "${S}/src/Darcs/Test/Patch/Info.hs" || die "sed s/findBy/find/ not necessary"
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

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="3"

# haddock-2.9.2 has xhtml as a dep, so disable haddock feature
CABAL_FEATURES="lib profile"
inherit haskell-cabal

DESCRIPTION="An XHTML combinator library"
HOMEPAGE="https://github.com/haskell/xhtml"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10.1
		>=dev-haskell/cabal-1.6"

src_prepare() {
	if has_version '>=dev-lang/ghc-7.2.1' && has_version '<dev-haskell/ghc-7.4.0'; then
		if ghc-pkg describe base | grep -q "trusted: False"; then
			eerror "Due to an oversight, the base package isn't trusted by default in ghc-7.2.1."
			eerror "To avoid the build failing with the error:"
			eerror "base:Prelude can't be safely imported! The package (base) the module resides in isn't trusted."
			eerror "it is necessary to run, once:"
			eerror "ghc-pkg trust base"
			die "base is not trusted"
		fi
	fi
	sed -e 's@base >= 4.0 && < 4.5@base >= 4.0 \&\& < 4.6@' \
		-i "${S}/${PN}.cabal" || die "Could not loosen dependencies"
}

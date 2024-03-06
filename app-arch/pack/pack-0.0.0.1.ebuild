# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit haskell-cabal

EGIT_COMMIT="0bd29ccae2662ef9ae1fabe707d84e4f84b36d53"
MY_P=${PN}-${EGIT_COMMIT}
DESCRIPTION="Haskell implementation of pack compression from the early 1980s"
HOMEPAGE="https://github.com/koalaman/pack/"
SRC_URI="
	https://github.com/koalaman/pack/archive/${EGIT_COMMIT}.tar.gz
		-> ${MY_P}.tar.gz
"
S=${WORKDIR}/${MY_P}
CABAL_FILE=${S}/pack-compression.cabal

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CABAL_CHDEPS=(
	'base >=4.9 && <4.10' 'base >=4.9'
)

RDEPEND="
	dev-lang/ghc:=
"
BDEPEND="
	>=dev-haskell/cabal-1.10
"

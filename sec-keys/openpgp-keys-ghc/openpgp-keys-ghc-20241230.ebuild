# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign GHC releases"
HOMEPAGE="https://www.haskell.org/ghc"

# To check who signed each version, look at the installation page
# Example: <https://www.haskell.org/ghc/download_ghc_9_8_2.html#binaries>
#
# NOTE: The installation page for 9.6.3 says it was signed by Bryan Richter,
# but the key has no user ID (33C3A599DB85EA9B8BAA1866B202264020068BFB).
SRC_URI="
	https://keys.openpgp.org/vks/v1/by-fingerprint/FFEB7CE81E16A36B3E2DED6F2DE04D4E97DB64AD
		-> FFEB7CE81E16A36B3E2DED6F2DE04D4E97DB64AD.asc
	https://keys.openpgp.org/vks/v1/by-fingerprint/88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4
		-> 88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4.asc
"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - ghc.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}

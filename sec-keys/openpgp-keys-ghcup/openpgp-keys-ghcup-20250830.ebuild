# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign GHCup releases"
HOMEPAGE="https://www.haskell.org/ghcup/install/#manual-installation"

# NOTE: Ben Gamari is listed on the homepage, but the key has no user ID
# (FE5AB6C91FEA597C3B31180B73EDE9E8CFBAEF01).
#
#NOTE: key 7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C is currently broken

# Zubin Duggal <zubin@well-typed.com> (shared by sec-keys/openpgp-keys-ghc)
SRC_URI+="
	https://keys.openpgp.org/vks/v1/by-fingerprint/88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4
		-> openpgp-keys-ghc-zduggal-88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4.asc
"

# Hécate <hecate@glitchbra.in>
SRC_URI+="
	https://keys.openpgp.org/vks/v1/by-fingerprint/EAF2A9A722C0C96F2B431CA511AAD8CEDEE0CAEF
		-> ${PN}-hecate-EAF2A9A722C0C96F2B431CA511AAD8CEDEE0CAEF.asc
"

# Julian Ospald <hasufell@posteo.de>
SRC_URI+="
	https://keys.openpgp.org/vks/v1/by-fingerprint/7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C
		-> ${PN}-jospald-7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C.asc
"

S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - ghcup.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}

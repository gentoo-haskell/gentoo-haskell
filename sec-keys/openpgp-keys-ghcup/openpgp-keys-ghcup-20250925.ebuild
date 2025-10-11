# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign GHCup releases"
HOMEPAGE="https://www.haskell.org/ghcup/install/#manual-installation"

# NOTE: Ben Gamari is listed on the homepage, but the key has no user ID
# (FE5AB6C91FEA597C3B31180B73EDE9E8CFBAEF01).

SEC_KEYS_VALIDPGPKEYS=(
	# Zubin Duggal <zubin@well-typed.com> (shared by sec-keys/openpgp-keys-ghc)
	'88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4:zduggal:openpgp'
	# Hécate <hecate@glitchbra.in>
	'EAF2A9A722C0C96F2B431CA511AAD8CEDEE0CAEF:hecate:openpgp'
	# Julian Ospald <hasufell@posteo.de>
	'7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C:jospald:openpgp'
)

inherit sec-keys

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

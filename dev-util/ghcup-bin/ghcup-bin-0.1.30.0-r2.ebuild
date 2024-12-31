# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit verify-sig

DESCRIPTION="The GHCup Haskell installer"
HOMEPAGE="https://www.haskell.org/ghcup/"

VERIFY_SIG_OPENPGP_KEY_PATH=/usr/share/openpgp-keys/ghcup.asc

# The list of binary name prefixes from upstream, chosen using $ARCH
ghcup_bin_prefix() {
	case ${1} in
		amd64) echo "x86_64-linux" ;;
		arm64) echo "aarch64-linux-static" ;;
		arm  ) echo "armv7-linux" ;;
		x86  ) echo "i386-linux" ;;
		""   ) echo "x86_64-linux" ;; # Failsafe for NO arch (pkgcheck seems to need this)

		*    ) die "Unsupported arch (no upstream distfiles available): ${ARCH}" ;;
	esac
}

# directory where upstream binaries live
GHCUP_BIN_DIR_URI="https://downloads.haskell.org/~ghcup/${PV}"

SRC_URI="
	amd64? (
		${GHCUP_BIN_DIR_URI}/$(ghcup_bin_prefix amd64)-ghcup-${PV}
			-> ${P}-$(ghcup_bin_prefix amd64)-exe
	)
	arm64? (
		${GHCUP_BIN_DIR_URI}/$(ghcup_bin_prefix arm64)-ghcup-${PV}
			-> ${P}-$(ghcup_bin_prefix arm64)-exe
	)
	arm? (
		${GHCUP_BIN_DIR_URI}/$(ghcup_bin_prefix arm)-ghcup-${PV}
			-> ${P}-$(ghcup_bin_prefix arm)-exe
	)
	x86? (
		${GHCUP_BIN_DIR_URI}/$(ghcup_bin_prefix x86)-ghcup-${PV}
			-> ${P}-$(ghcup_bin_prefix x86)-exe
	)

	verify-sig? (
		${GHCUP_BIN_DIR_URI}/SHA256SUMS
			-> ${P}-SHA256SUMS
		${GHCUP_BIN_DIR_URI}/SHA256SUMS.sig
			-> ${P}-SHA256SUMS.sig
	)
"

# No need for ${P} subdirectory
S="${WORKDIR}"

LICENSE="LGPL-3"
SLOT="0"

# Only keyword an arch if someone has done (extensive) testing with it
KEYWORDS="~amd64"

BDEPEND="${BDEPEND}
	verify-sig? (
		sec-keys/openpgp-keys-ghcup
	)
"

### Export some more variables specific to the local $ARCH, for convenience

# the binary name prefix
GHCUP_BIN_PREFIX="$(ghcup_bin_prefix "${ARCH}")"

# name (prefix) for our saved files in $DISTDIR (specific to local $ARCH!)
GHCUP_DISTDIR_PREFIX="${P}-${GHCUP_BIN_PREFIX}"

# The upstream name of the ghcup binary we will work with (specific to local $ARCH!)
GHCUP_BIN="${GHCUP_BIN_PREFIX}-ghcup-${PV}"

###

# Print _only_ the relevant line from the sumfile for our $GHCUP_BIN
ghcup_trim_sumfile() {
	grep ./${GHCUP_BIN}\$ "${S}/SHA256SUMS"
}

src_unpack() {
	cp -v "${DISTDIR}/${GHCUP_DISTDIR_PREFIX}-exe" \
		"${S}/${GHCUP_BIN}" || die # Match name in $S to upstream

	if use verify-sig; then
		verify-sig_verify_detached "${DISTDIR}/${P}"-SHA256SUMS{,.sig}

		for checksum_file in SHA256SUMS{,.sig}; do
			cp -v "${DISTDIR}/${P}-${checksum_file}" \
				"${S}/${checksum_file}" || die
		done

		sha256sum --check <(ghcup_trim_sumfile) || die
	fi
}

src_install() {
	exeinto /usr/bin
	newexe "${GHCUP_BIN}" ghcup
}

pkg_postinst() {
	elog 'Adjust your $PATH to run executables installed by GHCup:'
	elog "export PATH=\"\$HOME/.cabal/bin:\$HOME/.ghcup/bin:\$PATH\""
	elog 'See: <https://www.haskell.org/ghcup/install/#manual-installation>'
}

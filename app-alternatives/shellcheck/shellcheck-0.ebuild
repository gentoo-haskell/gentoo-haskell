# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	"main:>=dev-util/shellcheck-0.9.0-r2"
	chromiumos:dev-util/shellcheck-chromiumos
)

inherit app-alternatives

DESCRIPTION="shellcheck symlink"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	!<dev-util/shellcheck-0.9.0-r2
"

src_install() {
	case $(get_alternative) in
		main)
			dosym shellcheck-main /usr/bin/shellcheck
			;;
		chromiumos)
			dosym shellcheck-chromiumos /usr/bin/shellcheck
			;;
	esac
}

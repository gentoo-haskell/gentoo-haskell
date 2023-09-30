# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for pandoc"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=""
RDEPEND="|| ( app-text/pandoc-cli app-text/pandoc-bin[pandoc-symlink] <app-text/pandoc-3 )"
# (`app-text/pandoc-bin` is present upstream in the main `::gentoo` ebuild
# repository.)

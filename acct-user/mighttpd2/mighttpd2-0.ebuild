# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for www-servers/mighttpd2"
KEYWORDS="~amd64"

ACCT_USER_GROUPS=( "mighttpd2" )
ACCT_USER_ID="606" # Random unused UID
ACCT_USER_HOME="/var/lib/mighttpd2"

acct-user_add_deps

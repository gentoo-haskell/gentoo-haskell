# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for dev-util/hoogle"
KEYWORDS="~amd64"

ACCT_USER_GROUPS=( "hoogle" )
ACCT_USER_ID="605" # Random unused UID
ACCT_USER_HOME="/var/lib/hoogle"

acct-user_add_deps

#!/bin/sh

# add something like the following to
# your ~/.blogliterately/config
#     blog gentoo-haskell
#     url http://gentoohaskell.wordpress.com/xmlrpc.php
#     api wordpress
#     user "$WP_USER"
#     password "$WP_PASSWORD"

BlogLiterately \
    --hs-kate \
    --other-code-kate \
    gentoo-haskell \
    "$@"

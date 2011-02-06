#!/bin/sh

BlogLiterately \
    --hs-kate \
    --other-code-kate \
    http://gentoohaskell.wordpress.com/xmlrpc.php \
    "$WP_USER" \
    "$WP_PASSWORD" \
    "$@"

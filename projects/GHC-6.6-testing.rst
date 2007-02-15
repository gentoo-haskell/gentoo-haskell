===============
GHC 6.6 Testing
===============

Due to the restructure of bundled libraries from GHC 6.4 -> 6.6 we've had to
rewrite ebuild dependincies between packages and libraries.

To ensure that our new scheme works, we need to test it.

Test cases follow:

Test 1
======
 :status: untested

::

    < dcoutts_> 1: add the dummy packages to an overlay
    < dcoutts_> 2: modify existing packages to use the modular deps
    < dcoutts_> 3: test nothing breaks
    < dcoutts_> 4: add non-dummy packages and 6.6
    < dcoutts_> 5: upgrade


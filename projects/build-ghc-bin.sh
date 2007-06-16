
# we must be sure to build the binary package without using any flags
# that would make the binary require a specific cpu model.

# tuning for pentium4 is probably a reasonable choice for p4s and athlons
export CFLAGS="-O2 -pipe"

# build with the documentation and enable bootstrapping
export USE="-binary doc ghcbootstrap"

echo "you may also need to set PORTDIR_OVERLAY=\"\""
echo "and also ACCEPT_KEYWORDS=\"~\${arch}\""
echo "running:"
echo "  USE=\"${USE}\" CFLAGS=\"${CFLAGS}\" emerge --buildpkgonly =ghc-$1"

emerge --buildpkgonly =ghc-$1 || exit

echo "created /usr/portage/packages/dev-lang/ghc-$1.tbz2"
echo "to make the ghc-bin file just move it:"
echo "mv /usr/portage/packages/All/ghc-$1.tbz2 /usr/portage/distfiles/ghc-bin-$1.tbz2"

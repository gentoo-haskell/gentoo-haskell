# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-0.5.ebuild,v 1.2 2005/03/18 23:34:54 kosmikus Exp $

inherit ghc-package

cabal-bootstrap() {
	local setupmodule
	if [[ -f ${S}/Setup.lhs ]]; then
		setupmodule=${S}/Setup.lhs
	else
		if [[ -f ${S}/Setup.hs ]]; then
			setupmodule=${S}/Setup.hs
		else
			die "No Setup.lhs or Setup.hs found"
		fi
	fi
	$(ghc-getghc) -package Cabal ${setupmodule} -o setup
}

cabal-haddock() {
	./setup haddock || die "setup haddock failed"
}

cabal-configure() {
	./setup configure \
		--ghc --prefix=/usr \
		--with-compiler="$(ghc-getghc)" \
		--with-hc-pkg="$(ghc-getghcpkg)" \
		"$@" || die "setup configure failed"
}

cabal-build() {
	./setup build \
		|| die "setup build failed"
}

cabal-copy() {
	./setup copy \
		--copy-prefix="${D}/usr" \
		|| die "setup copy failed"

	# make GHCi .o files for any packages
	for lib in ${D}/usr/lib/*/libHS*.a; do
		ghc-makeghcilib ${lib}
	done

	# cabal is a bit eager about creating dirs,
	# so remove them if they are empty
	rmdir ${D}/usr/bin
}

cabal-pkg() {
	./setup register \
		--gen-script \
		|| die "setup register failed"
	if ghc-cabal; then
		# ghc supports Cabal; however, ghc-6.4 ships a slightly
		# broken version, which we fix here
		sed -i "s|update *$|update .installed-pkg-config|" register.sh
	fi
	# we want to manually build ghci-libs, so we remove the flag;
	# instead, we force the issue and write to the local config file
	# rather than the global one (which would cause an access violation
	# at this point anyway)
	sed -i "s|--auto-ghci-libs\(.*\)$|--force \1 -f\\\\|" \
		register.sh
	echo "${S}/$(ghc-localpkgconf)" >> register.sh
	ghc-setup-pkg
	./register.sh
	ghc-install-pkg
}

# exported function: cabal-style bootstrap configure and compile
haskell-cabal_src_compile() {
	cabal-bootstrap
	cabal-configure
	cabal-build
}

# exported function: cabal-style bootstrap configure and compile
haskell-cabal_src_install() {
	cabal-copy
	cabal-pkg
}

EXPORT_FUNCTIONS src_compile src_install

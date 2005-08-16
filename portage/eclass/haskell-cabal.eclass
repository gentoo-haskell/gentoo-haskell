# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-0.5.ebuild,v 1.2 2005/03/18 23:34:54 kosmikus Exp $

inherit ghc-package


for feature in ${CABAL_FEATURES}; do
	case ${feature} in
		haddock)   CABAL_USE_HADDOCK=yes;;
		alex)      CABAL_USE_ALEX=yes;;
		happy)     CABAL_USE_HAPPY=yes;;
		c2hs)      CABAL_USE_C2HS=yes;;
		cpphs)     CABAL_USE_CPPHS=yes;;
		profile)   CABAL_USE_PROFILE=yes;;
		bootstrap) CABAL_BOOTSTRAP=yes;;
		*) ewarn "Unknown entry in CABAL_FEATURES: ${feature}";;
	esac
done

if [[ -n ${CABAL_USE_HADDOCK} ]]; then
	IUSE="${IUSE} doc"
	DEPEND="${DEPEND} doc? ( dev-haskell/haddock )"
	cabalconf="${cabalconf} --with-haddock=/usr/bin/haddock"
fi

if [[ -n ${CABAL_USE_ALEX} ]]; then
	DEPEND="${DEPEND} dev-haskell/alex"
	cabalconf="${cabalconf} --with-alex=/usr/bin/alex"
fi

if [[ -n ${CABAL_USE_HAPPY} ]]; then
	DEPEND="${DEPEND} dev-haskell/happy"
	cabalconf="${cabalconf} --with-happy=/usr/bin/happy"
fi

if [[ -n ${CABAL_USE_C2HS} ]]; then
	DEPEND="${DEPEND} dev-haskell/c2hs"
	cabalconf="${cabalconf} --with-c2hs=/usr/bin/c2hs"
fi

if [[ -n ${CABAL_USE_CPPHS} ]]; then
	DEPEND="${DEPEND} dev-haskell/cpphs"
	cabalconf="${cabalconf} --with-cpphs=/usr/bin/cpphs"
fi

if [[ -n ${CABAL_USE_PROFILE} ]]; then
	IUSE="${IUSE} profile"
fi

# We always use a standalone version of Cabal, rather than the one that comes
# with GHC. But of course we can't depend on cabal when building cabal itself.
if [[ -z ${CABAL_BOOTSTRAP} ]]; then
	DEPEND="${DEPEND} >cabal-1.0"
fi


cabal-bootstrap() {
	local setupmodule
	local cabalversion
	if [[ -f ${S}/Setup.lhs ]]; then
		setupmodule=${S}/Setup.lhs
	else
		if [[ -f ${S}/Setup.hs ]]; then
			setupmodule=${S}/Setup.hs
		else
			die "No Setup.lhs or Setup.hs found"
		fi
	fi

	# We build the setup program using the latest version of
	# cabal that we have installed
	cabalversion=$(ghc-bestcabalversion)
	einfo "Using ${cabalversion}."
	$(ghc-getghc) -package ${cabalversion} ${setupmodule} -o setup \
		|| die "compiling ${setupmodule} failed"
}

cabal-haddock() {
	./setup haddock || die "setup haddock failed"
}

cabal-configure() {
	if [[ -n ${CABAL_USE_PROFILE} ]] && use profile; then
		cabalconf="${cabalconf} --enable-executable-profiling"
	fi

	./setup configure \
		--ghc --prefix=/usr \
		--with-compiler="$(ghc-getghc)" \
		--with-hc-pkg="$(ghc-getghcpkg)" \
		${cabalconf} \
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

	# cabal is a bit eager about creating dirs,
	# so remove them if they are empty
	rmdir ${D}/usr/bin 2> /dev/null

	# GHC 6.4 has a bug in get/setPermission and Cabal 1.1.1 has
	# no workaround.
	# set the +x permission on executables
	if [[ -d ${D}/usr/bin ]] ; then
		chmod +x ${D}/usr/bin/*
	fi
}

cabal-cabal2conf() {
	if [[ -n ${CABAL_BOOTSTRAP} ]]; then
		${S}/cabal2conf
	else
		cabal2conf
	fi
}

cabal-pkg() {
	local conffilename
	conffilename=${P}.tmpconf

	# This could possibly fail if the .setup-config does not exist (eg if it
	# is not using Distribution.Simple) or if the .setup-config was written by
	# a different version of cabal to the one that cabal2conf was built with.
	cabal-cabal2conf > ${conffilename} || die "cabal2conf failed"

	ghc-setup-pkg ${conffilename}
	ghc-install-pkg
}

# exported function: cabal-style bootstrap configure and compile
cabal_src_compile() {
	cabal-bootstrap
	cabal-configure
	cabal-build

	if [[ -n ${CABAL_USE_HADDOCK} ]] && use doc; then
		cabal-haddock
	fi
}
haskell-cabal_src_compile() {
	cabal_src_compile
}

# exported function: cabal-style copy and register
cabal_src_install() {
	cabal-copy
	cabal-pkg

	if [[ -n ${CABAL_USE_HADDOCK} ]] && use doc; then
		dohtml dist/doc/html/*
	fi
}
haskell-cabal_src_install() {
	cabal_src_install
}

EXPORT_FUNCTIONS src_compile src_install

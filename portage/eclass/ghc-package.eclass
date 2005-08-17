# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ghc-package.eclass,v 1.9 2005/04/08 01:13:39 araujo Exp $
#
# Author: Andres Loeh <kosmikus@gentoo.org>
#
# This eclass helps with the Glasgow Haskell Compiler's package
# configuration utility.

inherit versionator

# promote /opt/ghc/bin to a better position in the search path
PATH="/usr/bin:/opt/ghc/bin:${PATH}"

# for later configuration using environment variables/
# returns the name of the ghc executable
ghc-getghc() {
	echo "ghc"
}

# returns the name of the ghc-pkg executable
ghc-getghcpkg() {
	echo "ghc-pkg"
}

# returns the name of the ghc-pkg binary (ghc-pkg
# itself usually is a shell script, and we have to
# bypass the script under certain circumstances);
# for Cabal, we add an empty global package config file,
# because for some reason the global package file
# must be specified
ghc-getghcpkgbin() {
	if ghc-cabal; then
		echo '[]' > ${T}/empty.conf
		echo $(ghc-libdir)/"ghc-pkg.bin" "--global-conf=${T}/empty.conf"
	else
		echo $(ghc-libdir)/"ghc-pkg.bin"
	fi
}

# returns the version of ghc
_GHC_VERSION_CACHE=""
ghc-version() {
	if [[ -z "${_GHC_VERSION_CACHE}" ]]; then
		_GHC_VERSION_CACHE="$($(ghc-getghc) --version | sed 's:^.*version ::')"
	fi
	echo "${_GHC_VERSION_CACHE}"
}

# this function can be used to determine if ghc itself
# uses the Cabal package format; it has nothing to do
# with the Cabal libraries ... ghc uses the Cabal package
# format since version 6.4
ghc-cabal() {
	version_is_at_least "6.4" "$(ghc-version)"
}

# return the best version of the Cabal library that is available
ghc-bestcabalversion() {
	local cabalpackage
	local cabalversion
	if ghc-cabal; then
		# Try if ghc-pkg can determine the latest version.
		# If not, use portage.
		cabalpackage="$($(ghc-getghcpkg) latest Cabal 2> /dev/null)"
		if [[ $? -eq 0 ]]; then
			cabalversion=${cabalpackage#Cabal-}
		else
			cabalpackage=$(best_version cabal)
			cabalversion=${cabalpackage#dev-haskell/cabal-}
			cabalversion=${cabalversion%-r*}
			cabalversion=${cabalversion%_pre*}
		fi
		echo Cabal-${cabalversion}
	else
		# older ghc's don't support package versioning
		echo Cabal
	fi
}

# returns the library directory
_GHC_LIBDIR_CACHE=""
ghc-libdir() {
	if [[ -z "${_GHC_LIBDIR_CACHE}" ]]; then
		_GHC_LIBDIR_CACHE="$($(ghc-getghc) --print-libdir)"
	fi
	echo "${_GHC_LIBDIR_CACHE}"
}

# returns the (Gentoo) library configuration directory
ghc-confdir() {
	echo $(ghc-libdir)/gentoo
}

# returns the name of the local (package-specific)
# package configuration file
ghc-localpkgconf() {
	echo "${PF}.conf"
}

# make a ghci foo.o file from a libfoo.a file
ghc-makeghcilib() {
	local outfile
	outfile="$(dirname $1)/$(basename $1 | sed 's:^lib\?\(.*\)\.a$:\1.o:')"
	ld --relocatable --discard-all --output="${outfile}" --whole-archive $1
}

# creates a local (package-specific) package
# configuration file; the arguments should be
# uninstalled package description files, each
# containing a single package description; if
# no arguments are given, the resulting file is
# empty
ghc-setup-pkg() {
	local localpkgconf
	localpkgconf="${S}/$(ghc-localpkgconf)"
	echo '[]' > ${localpkgconf}
	for pkg in $*; do
		$(ghc-getghcpkgbin) -f ${localpkgconf} -u --force \
			< ${pkg} || die "failed to register ${pkg}"
	done
}

# fixes the library and import directories path
# of the package configuration file
ghc-fixlibpath() {
	sed -i "s|$1|$(ghc-libdir)|g" ${S}/$(ghc-localpkgconf)
	if [[ -n "$2" ]]; then
		sed -i "s|$2|$(ghc-libdir)/imports|g" ${S}/$(ghc-localpkgconf)
	fi
}

# moves the local (package-specific) package configuration
# file to its final destination
ghc-install-pkg() {
	mkdir -p ${D}/$(ghc-confdir)
	cat ${S}/$(ghc-localpkgconf) | sed "s|${D}||g" \
		> ${D}/$(ghc-confdir)/$(ghc-localpkgconf)
}

# registers all packages in the local (package-specific)
# package configuration file
ghc-register-pkg() {
	local localpkgconf
	localpkgconf="$(ghc-confdir)/$1"
	if [[ -f ${localpkgconf} ]]; then
		for pkg in $(ghc-listpkg ${localpkgconf}); do
			ebegin "Registering ${pkg} "
			$(ghc-getghcpkgbin) -f ${localpkgconf} -s ${pkg} \
				| $(ghc-getghcpkg) -u --force > /dev/null
			eend $?
		done
	fi
}

# re-adds all available .conf files to the global
# package conf file, to be used on a ghc reinstallation
ghc-reregister() {
	einfo "Re-adding packages ..."
	einfo "(This may cause several warnings, but they should be harmless.)"
	if [ -d "$(ghc-confdir)" ]; then
		pushd $(ghc-confdir) > /dev/null
		for conf in *.conf; do
			einfo "Processing ${conf} ..."
			ghc-register-pkg ${conf}
		done
		popd > /dev/null
	fi
}

# unregisters a package configuration file
# protected are all packages that are still contained in
# another package configuration file
ghc-unregister-pkg() {
	local localpkgconf
	local i
	local pkg
	local protected
	localpkgconf="$(ghc-confdir)/$1"

	for i in $(ghc-confdir)/*.conf; do
		[[ "${i}" != "${localpkgconf}" ]] && protected="${protected} $(ghc-listpkg ${i})"
	done
	# protected now contains the packages that cannot be unregistered yet

	if [[ -f ${localpkgconf} ]]; then
		for pkg in $(ghc-reverse "$(ghc-listpkg ${localpkgconf})"); do
			if $(ghc-elem "${pkg}" "${protected}"); then
				einfo "Package ${pkg} is protected."
			else
				ebegin "Unregistering ${pkg} "
				$(ghc-getghcpkg) -r ${pkg} --force > /dev/null
				eend $?
			fi
		done
	fi
}

# help-function: reverse a list
ghc-reverse() {
	local result
	local i
	for i in $1; do
		result="${i} ${result}"
	done
	echo ${result}
}

# help-function: element-check
ghc-elem() {
	local i
	for i in $2; do
		[[ "$1" == "${i}" ]] && return 0
	done
	return 1
}

# show the packages in a package configuration file
ghc-listpkg() {
	local ghcpkgcall
	local i
	for i in $*; do
		if ghc-cabal; then
			echo $($(ghc-getghcpkg) list -f ${i}) \
				| sed \
					-e "s|^.*${i}:\([^:]*\).*$|\1|" \
					-e "s|/.*$||" \
					-e "s|,| |g" -e "s|[()]||g"
		else
			echo $($(ghc-getghcpkgbin) -l -f ${i}) \
				| cut -f2 -d':' \
				| sed 's:,: :g'
		fi
	done
}

# exported function: registers the package-specific package
# configuration file
ghc-package_pkg_postinst() {
	ghc-register-pkg $(ghc-localpkgconf)
}

# exported function: unregisters the package-specific package
# configuration file; a package contained therein is unregistered
# only if it the same package is not also contained in another
# package configuration file ...
ghc-package_pkg_prerm() {
	ghc-unregister-pkg $(ghc-localpkgconf)
}

EXPORT_FUNCTIONS pkg_postinst pkg_prerm

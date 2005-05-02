# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ghc-package.eclass,v 1.9 2005/04/08 01:13:39 araujo Exp $
#
# Author: Andres Loeh <kosmikus@gentoo.org>
#
# This eclass helps with the Glasgow Haskell Compiler's package
# configuration utility.

inherit versionator

ECLASS="ghc-package"
INHERITED="${INHERITED} ${ECLASS}"

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
# for Cabal, we add the global package config file,
# because for some reason that's required
ghc-getghcpkgbin() {
	if ghc-cabal; then
		echo $(ghc-libdir)/"ghc-pkg.bin" "--global-conf=$(ghc-libdir)/package.conf"
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

# returns true for ghc >= 6.4
ghc-cabal() {
	version_is_at_least "6.4" "$(ghc-version)"
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
	echo '[' > ${localpkgconf}
	while [ -n "$1" ]; do
		cat "$1" >> ${localpkgconf}
		shift
		[ -n "$1" ] && echo ',' >> ${localpkgconf}
	done
	echo ']' >> ${localpkgconf}
}

# fixes the library and import directories path
# of the package configuration file
ghc-fixlibpath() {
    sed -i "s|$1|$(ghc-libdir)|" ${S}/$(ghc-localpkgconf)
	if [[ -n "$2" ]]; then
		sed -i "s|$2|$(ghc-libdir)/imports|" ${S}/$(ghc-localpkgconf)
	fi
}

# moves the local (package-specific) package configuration
# file to its final destination
ghc-install-pkg() {
	mkdir -p ${D}/$(ghc-confdir)
	cat ${S}/$(ghc-localpkgconf) | sed "s:${D}::" \
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

# unregisters ...
ghc-unregister-pkg() {
	local localpkgconf
	localpkgconf="$(ghc-confdir)/$1"
	if [[ -f ${localpkgconf} ]]; then
		for pkg in $(ghc-reverse "$(ghc-listpkg ${localpkgconf})"); do
			ebegin "Unregistering ${pkg} "
			$(ghc-getghcpkg) -r ${pkg} --force > /dev/null
			eend $?
		done
	fi
}

# help-function: reverse a list
ghc-reverse() {
	local result
	for i in $1; do
		result="${i} ${result}"
	done
	echo ${result}
}

# show the packages in a package configuration file
ghc-listpkg() {
	local ghcpkgcall
	if ghc-cabal; then
		echo $($(ghc-getghcpkg) list -f $1) \
			| sed \
				-e "s|^.*${f}:\([^:]*\).*$|\1|" \
				-e "s|/.*$||" \
				-e "s|,| |g" -e "s|[()]||g"
	else
		echo $($(ghc-getghcpkgbin) -l -f $1) \
			| cut -f2 -d':' \
			| sed 's:,: :g'
	fi
}

# exported function: registers the package-specific package
# configuration file
ghc-package_pkg_postinst() {
	ghc-register-pkg $(ghc-localpkgconf)
}

# exported function: unregisters the package-specific
# package configuration file, under the condition that
# after removal, no other instances of the package will
# be left (necessary check because ghc packages are not
# versioned)
ghc-package_pkg_prerm() {
	has_version "<${CATEGORY}/${PF}" || has_version ">${CATEGORY}/${PF}" \
		|| ghc-unregister-pkg $(ghc-localpkgconf)
}

EXPORT_FUNCTIONS pkg_postinst pkg_prerm

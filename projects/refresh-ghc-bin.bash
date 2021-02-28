#!/usr/bin/env bash

#
# The script is intended to build latest yet unkeyworded ghc for given $ARCH.
#
# It is quite heavyweight and works as follows:
#   - download latest stage3
#   - unpack stage3
#   - chroot there
#   - [in chroot] install latest stable ghc with USE=binary
#   - [in chroot] install latest unkeyworded ghc with USE=ghcbootstrap and --buildpkg
#   - move final binary or reported errors to known location
#

# example for x86:
#  path/to/refresh-ghc-bin.bash --target-arch=x86
#  path/to/refresh-ghc-bin.bash --target-arch=x86 --stage3-url=http://distfiles.gentoo.org/releases/x86/autobuilds/latest-stage3-i686.txt --needed-atom='=dev-lang/ghc-8.2.1_rc1'
# what I usually use:
#  path/to/refresh-ghc-bin.bash --target-arch=x86   --temp-tmpfs
#  path/to/refresh-ghc-bin.bash --target-arch=amd64 --temp-tmpfs

# to make reports more readable
# en_GB.UTF-8 might be better
# but it would require locale regen
export LANG=C

die() {
    echo "ERROR: $@"
    exit 1
}

i() {
    echo "$@"
}

run() {
    echo "RUN $@"
    "$@" || die "failed to run '$@'"
}

# gentoo arch, like x86, alpha
target_arch=
# pointer to .txt files on gentoo mirrors:
#    http://distfiles.gentoo.org/releases/x86/autobuilds/latest-stage3-i686.txt
stage3_url=
# if you happen to need hardened here
# you might like to use '--chroot-profile=hardened/linux/amd64'
chroot_profile=
# this peeks latest ghc in ::gentoo
# you can override version as --needed-atom='=dev-lang/ghc-8.2.1_rc1'
needed_atom="dev-lang/ghc"
dry_run=
autobuild_machine=
keep_temp_chroot=
makeopts=auto
# default to current directory
temp_dir=
# mount fresh temp dir as tmpfs
temp_tmpfs=no

default_autobuild_machine() {
    local arch=$1

    case "${arch}" in
        sparc) echo "sparc64"    ;;
        x86)   echo "i686"       ;;
        *)     echo "${arch}"    ;;
    esac
}

autobuild_dir() {
    local arch=$1
    local abd=${arch}

    case "${arch}" in
        ppc64) abd="ppc" ;;
    esac

    echo "http://distfiles.gentoo.org/releases/${abd}/autobuilds"
}

while [[ ${#@} -gt 0 ]]; do
    case "$1" in
        --autobuild-machine=*)
            autobuild_machine=${1#--autobuild-machine=}
            ;;
        --target-arch=*)
            target_arch=${1#--target-arch=}
            ;;
        --stage3-url=*)
            stage3_url=${1#--stage3-url=}
            ;;
        --chroot-profile=*)
            chroot_profile=${1#--chroot-profile=}
            ;;
        --needed-atom=*)
            needed_atom=${1#--needed-atom=}
            ;;
        --makeopts=*)
            makeopts=${1#--makeopts=}
            ;;
        --temp-dir=*)
            temp_dir=${1#--temp-dir=}/
            ;;
        --dry-run)
            dry_run=yes
            ;;
        --keep-temp-chroot)
            keep_temp_chroot=yes
            ;;
        --temp-tmpfs)
            temp_tmpfs=yes
            ;;
        *)
            die "unknown option: $1"
            ;;
    esac
    # parsed fine
    shift
done

[[ -z ${target_arch} ]] && target_arch=$(portageq envvar ARCH)
[[ -z ${autobuild_machine} ]] && autobuild_machine=$(default_autobuild_machine "${target_arch}")
[[ -z ${stage3_url} ]] && stage3_url=$(autobuild_dir "${target_arch}")/latest-stage3-${autobuild_machine}.txt
[[ -z ${chroot_profile} ]] && chroot_profile=default/linux/${target_arch}/17.0

i "target ARCH:       ${target_arch}"
i "autobuild machine: ${autobuild_machine}"
i "stage3 URL:        ${stage3_url}"
i "chroot profile:    ${chroot_profile}"
i "built atom:        ${needed_atom}"
i "keep temp chroot:  ${keep_temp_chroot}"
i "makeopts:          ${makeopts}"
i "temp_dir:          ${temp_dir}"
i "temp_tmpfs:        ${temp_tmpfs}"

[[ -z ${dry_run} ]] || exit 0

first() {
    echo "$1"
}

# we get a string of form:
#     "20141204/stage3-amd64-20141204.tar.bz2 207889127"
# or
#     "20180117T214502Z/stage3-i686-20180117T214502Z.tar.xz 179923656"
relative_stage3_bz2=$(first `wget "${stage3_url}" -O - | fgrep .tar`)
full_stage3_bz2=$(dirname "${stage3_url}")/${relative_stage3_bz2}
stage3_name=$(basename "${full_stage3_bz2}")

run wget -c "${full_stage3_bz2}"
stage_dir=$(pwd)

chroot_temp=${temp_dir}__ghc_chroot_$(date "+%F-%H-%M-%S")
chroot_subdir=gentoo-${target_arch}
chroot_script=${chroot_subdir}.sh
chroot_bits=as-is
ghc_autobuilds_dir=ghc-autobuilds/${target_arch}/$(date "+%F-%H-%M-%S")

run mkdir -p "${ghc_autobuilds_dir}"
# make it absolute to be agnostic to chdirs
ghc_autobuilds_dir=$(realpath "${ghc_autobuilds_dir}")

run mkdir "${chroot_temp}"
[[ ${temp_tmpfs} = yes ]] && run mount -t tmpfs tmpfs "${chroot_temp}"
(
    run cd "${chroot_temp}"
    run mkdir "${chroot_subdir}"
    (
        run cd "${chroot_subdir}"
        run tar -xf "${stage_dir}"/"${stage3_name}"

        cat >init-portage-env.bash <<-EOF
	echo "Setting up profile"
	echo 'source /bound/conf/make.conf' >> /etc/portage/make.conf
	eselect profile set ${chroot_profile}
	EOF

        cat >sanitize-use-defaults.bash <<-EOF
	echo "Sanitizing USE defaults"
	# USE=bindist in stages is a releng bug: https://bugs.gentoo.org/473332
	echo 'USE="\${USE} -bindist"' >> /etc/portage/make.conf
	FEATURES="${FEATURES} -test -strict -stricter"                     emerge -uv1N dev-libs/openssl net-misc/openssh

	# python[sqlite] is needed for sphinx
	echo 'USE="\${USE} sqlite"' >> /etc/portage/make.conf

	# disable docs compression in binpkg. Let user's make.conf decide:
	# https://bugs.gentoo.org/667316
	echo 'PORTAGE_COMPRESS=true' >> /etc/portage/make.conf
	EOF

        cat >refresh-ghc.bash <<-EOF
	mkdir -p /etc/portage/package.accept_keywords
	mkdir -p /etc/portage/package.unmask
	mkdir -p /etc/portage/package.use
	echo "Installing ~arch binary ghc"
	echo "dev-lang/ghc              ~${target_arch}" >  /etc/portage/package.accept_keywords/haskell
	echo "app-admin/haskell-updater ~${target_arch}" >> /etc/portage/package.accept_keywords/haskell
	FEATURES="${FEATURES} -test -strict -stricter" USE="binary ${USE}" emerge --verbose --oneshot dev-lang/ghc || exit 1
	echo "Building pkg '${needed_atom}'"
	echo "${needed_atom} ~${target_arch} **" > /etc/portage/package.accept_keywords/ghc
	echo "${needed_atom}"                    > /etc/portage/package.unmask/ghc
	echo "${needed_atom} -binary doc ghcbootstrap ghcmakebinary ${USE}" > /etc/portage/package.use/ghc
	FEATURES="${FEATURES} -test -strict -stricter"                     emerge --verbose --buildpkg=y "${needed_atom}"
	EOF

        cat >store-results.bash <<-EOF
	for f in \$(find \$(portageq envvar PORTAGE_TMPDIR) -type f -name build.log)
	do
	    cp -v -- "\$f" "/bound/result/\${f//\//_}"
	done
	for f in \$(find \$(portageq envvar PKGDIR) -type f -name '*.tbz2')
	do
	    cp -v -- "\$f" "/bound/result/\${f//\//_}"
	done
	EOF
    )
    run git clone https://github.com/trofi/gentoo-chrootiez.git
    (
        run cd gentoo-chrootiez/bound
        run ./make_typical_binds.sh
        run ./make_typical_confs.sh --makeopts=${makeopts}
        run ln -s "${ghc_autobuilds_dir}" result
    )

    cat >"${chroot_script}" <<-EOF
	gentoo-chrootiez/scripts/run_chroot.sh ${chroot_subdir} ${chroot_bits} "\$@"
	EOF

    run bash "${chroot_script}" '/init-portage-env.bash'
    run bash "${chroot_script}" '/sanitize-use-defaults.bash'
    run bash "${chroot_script}" '/refresh-ghc.bash'
    run bash "${chroot_script}" '/store-results.bash'
)

if [[ -z ${keep_temp_chroot} ]]; then
    echo "cleanup '${chroot_temp}'"
    [[ ${temp_tmpfs} = yes ]] && umount "${chroot_temp}"
    rm -rf -- "${chroot_temp}"
else
    echo "keeping '${chroot_temp}'"
fi

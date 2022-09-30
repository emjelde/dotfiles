#!/bin/bash

# Generate the files for the INITRAMFS_SOURCE kernel option

set -o errexit -o nounset

force=false
bdeps=false

help=$(cat <<'USAGE'
Usage: kernel/gen-initramfs.sh [OPTION]

  -f, --force       Replace /usr/src/initramfs/initramfs.list
  -d, --with-bdeps  Install initramfs dependencies
  -h, --help        Display this help and exit
USAGE
)

opts="$(getopt -o fdh -l force,with-bdeps,help -n kernel/gen-initramfs.sh -- "$@")"
eval set -- "$opts"
while true; do case "$1" in
   -f|--force) shift; force=true ;;
   -d|--with-bdeps) shift; bdeps=true ;;
   -h|--help) shift; echo "$help"; exit 0 ;;
   --) shift; break ;;
esac done

if $bdeps; then
   emerge --quiet --noreplace --with-bdeps=y \
      sys-fs/btrfs-progs \
      sys-fs/cryptsetup \
      sys-fs/lvm2
   rc-update add lvm boot
fi

initramfs_source="${INITRAMFS_SOURCE:-/usr/src/initramfs/initramfs.list}"

if [ -f "$initramfs_source" ] && ! $force; then
   (>&2 echo "Refusing to replace '${initramfs_source}' without --force")
   exit 128
fi

# Find GCC library path for extra libraries needed by cryptsetup
export LIBGCCPATH="/usr/lib/gcc/$(s=$(gcc-config -c); echo ${s%-*}/${s##*-})"

export INITRAMFS_DIR=$(dirname "$initramfs_source")
mkdir --parents "$INITRAMFS_DIR"

envsubst '$INITRAMFS_DIR $LIBGCCPATH' < <(${SOURCE:-.}/kernel/initramfs.list) > "$initramfs_source"

if [ -n "${KEY_FILE:-}" ] && [ -n "${LUKS_UUID:-}" ] && \
   [ -n "${ROOT_UUID:-}" ] && [ -n "${ROOT_VOLUME_GROUP:-}" ]
then
   envsubst '$LUKS_UUID $ROOT_VOLUME_GROUP' < ${SOURCE:-.}/kernel/initramfs.init > "${INITRAMFS_DIR}/init"
   envsubst '$ROOT_UUID' < ${SOURCE:-.}/kernel/initramfs.fstab > "${INITRAMFS_DIR}/fstab"
   cp "$KEY_FILE" "${INITRAMFS_DIR}/key"
fi

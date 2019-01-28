#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo ""
  echo "  Note: All files get written to /output"
  echo "  Usage:"
  echo ""
  echo "  > mkimg <device> <filename>                  "
  echo "    # example: mkimg /dev/sda mybackup.dd "
  echo ""
  echo "  > samdump <partition> <hivepath> <filename>              "
  echo "    # example: samdump /dev/sda1 Windows/System32/config myhashes"
  echo ""
  echo "  > shell                                      "
  echo ""
  exit 1
fi

case $1 in
  mkimg)
    dcfldd if=${2} hash=md5 of=/output/${3} bs=512
    ;;
  samdump)
    DEVICE=$2
    MP="/tmp/mount/${2}"
    mkdir -p /tmp/mount
    mount -t ntfs ${2} ${MP}
    sync
    pushd ${MP}
    bkhive SYSTEM /output/hive.txt
    samdump2 SAM /output/hive.txt > /output/hash.txt
    sync
    umount ${MP}
    sync
  shell)
    exec /bin/bash
    ;;
esac

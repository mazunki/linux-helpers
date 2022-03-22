#!/bin/sh

MNT_PATH=/mnt/gentoo
ROOT_DEVICE=/dev/nvme0n1p2
EFI_DEVICE=/dev/nvme0n1p1

mount -o defaults ${ROOT_DEVICE} ${MNT_PATH} || exit
mount -o defaults ${EFI_DEVICE} ${MNT_PATH}/boot/efi || exit

cp --dereference /etc/resolv.conf ${MNT_PATH}/etc/ || exit

echo "Using ${MNT_PATH} as mountpoint"
mount -o defaults --types proc /proc ${MNT_PATH}/proc || exit
mount -o defaults --rbind /sys ${MNT_PATH}/sys || exit
mount -o defaults --make-rslave ${MNT_PATH}/sys || exit
mount -o defaults --rbind /dev ${MNT_PATH}/dev || exit
mount -o defaults --make-rslave ${MNT_PATH}/dev || exit
mount -o defaults --rbind /run ${MNT_PATH}/run || exit
mount -o defaults --make-rslave ${MNT_PATH}/run || exit
mount -o defaults --rbind ./s ${MNT_PATH}/usr/local/bin || echo "Couldn't mount /usr/local/bin"
echo "Mounted filesystems succesfully"

chroot /mnt/gentoo /bin/bash


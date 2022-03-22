#!/bin/sh

genkernel \
	--install \
	--all-ramdisk-modules \
	--firmware \
	--kerneldir=/usr/src/linux \
	--kernel-config=/usr/src/linux/.config \
	"$@" ramdisk

# replace kernelconfig= with --oldconfig if you wanna use current (/proc/config.gz)
# also make sure that /usr/src/linux is actually the current kernel. use diff <(zcat /proc/config.gz) /usr/src/linux/.config for that
# --loglevel=[0..5]. complete log is in /var/log/genkernel.log

# actions = 
#	all: initrd + kernel + modules
#	bzImage: kernel
#	kernel: kernel + modules
#	initramfs: initrd
#	ramdisk: initrd

# --install puts the images (bzImage + kernel) into /boot
# --all-ramdisk-modules because we are autistic
# --firmware for support babieeee


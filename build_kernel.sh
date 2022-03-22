#!/bin/sh

[ -d /usr/src/linux ] || exit

genkernel --save-config --all-ramdisk-modules --integrated-initramfs all

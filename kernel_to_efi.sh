#!/bin/sh

#if [ -x "/usr/bin/tree" ]; then 
#	tree -C /boot 
#else
#	ls -R --color=auto /boot
#	echo "================="
#fi

EFI_DRIVE=/dev/nvme0n1
ESP_PARTN=1
ROOT_PART=/dev/nvme0n1p2
ROOT_UUID=$(lsblk -n -o PARTUUID ${ROOT_PART})

# echo "Copying kernel from /usr/src/linux into /boot/efi/Gentoo"

# cp /usr/src/linux/arch/x86_64/boot/bzImage /boot/efi/Gentoo/bootx64.efi

echo "Telling UEFI about bootx64.efi on ${EFI_DRIVE} partition ${ESP_PARTN}, with root=${ROOT_UUID}"

efibootmgr --create \
	--quiet \
	--disk ${EFI_DRIVE} \
	--part ${ESP_PARTN} \
	--label 'Loonis Toonvalds' \
	--loader '\gentoo\bootx64.efi' \
	-u "root=PARTUUID=${ROOT_UUID} rootfstype=btrfs rootflags=subvol=/ initrd=\\gentoo\\initrd.img quiet" \
	|| exit
#	efibootmgr --create \
#	--quiet \
#	--disk ${EFI_DRIVE} \
#	--part ${ESP_PARTN} \
#	--label 'SKARNET BAGOTTINI' \
#	--loader '\gentoo\bootx64.efi' \
#	-u "root=PARTUUID=${ROOT_UUID} rootfstype=btrfs rootflags=subvol=/ initrd=\\gentoo\\initrd.img init=/sbin/s6-init quiet" \
#	|| exit
# subvol=5 is the objectid for /
# -u "root=PARTUUID=${ROOT_UUID} rootfstype=btrfs rootflags=subvol=subvol_root" \
echo "Ok"


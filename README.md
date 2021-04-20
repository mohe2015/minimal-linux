
nix develop .#devShell.test

# AARCH64

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- tinyconfig #defconfig # only first time
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- gconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu-


https://stackoverflow.com/questions/35245247/writing-my-own-init-executable
https://stackoverflow.com/questions/10437995/initramfs-built-into-custom-linux-kernel-is-not-running

CONFIG_INITRAMFS_SOURCE=../rootfs.cpio.gz

https://stackoverflow.com/questions/24583614/want-to-build-bare-linux-system-that-has-only-a-kernel-and-one-binary

sudo mount /dev/sdc1 /mnt/
sudo mkfs.fat -F32 /dev/sdc1
sudo fdisk /dev/sdc
sudo fdisk -l


sudo mkdir -p /mnt/EFI/boot
sudo cp linux/arch/x86/boot/bzImage /mnt/EFI/boot/bootx64.efi


blkid | grep sdc


https://wiki.gentoo.org/wiki/EFI_stub_kernel
https://www.rodsbooks.com/efi-bootloaders/efistub.html












gcc -static init.c -o init

make isoimage FDINITRD="$ROOTFS_PATH"
sudo dd if=arch/x86/boot/image.iso of=/dev/sdX

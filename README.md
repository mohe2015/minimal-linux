
nix develop .#devShell.test

# AARCH64

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- tinyconfig #defconfig # only first time
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- gconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- menuconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- -j16
ls -lh arch/arm64/boot/Image
cd ..
make program
https://rosettacode.org/wiki/Category:AArch64_Assembly

https://github.com/qemu/qemu/blob/master/util/log.c

https://github.com/s-matyukevich/raspberry-pi-os/issues/8

TODO
CONFIG_INITRAMFS_SOURCE=../rootfs.cpio.gz


SEEMS TO WORK:

qemu-system-aarch64 -machine type=raspi3b -kernel linux/arch/arm64/boot/Image -append "earlyprintk=ttyAMA0,115200 loglevel=8 console=ttyAMA0,115200" -dtb linux/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb -nographic





qemu-system-aarch64 -D log -d cpu -machine type=raspi3b -serial stdio -kernel linux/arch/arm64/boot/Image -initrd rootfs.cpio.gz


qemu-system-aarch64 -D log -d cpu -machine type=raspi3b -kernel /run/media/moritz/boot/kernel8.img     -append "rw earlyprintk=ttyAMA0,115200 loglevel=8 console=ttyAMA0,115200 root=PARTUUID=6c586e13-02 rootfstype=ext4 rootwait" -dtb /run/media/moritz/boot/bcm2710-rpi-3-b.dtb -m 1024     -drive id=hd-root,file=/home/moritz/Downloads/2020-08-20-raspios-buster-arm64.img,format=raw -serial mon:stdio     -nographic

qemu-system-aarch64 -machine type=raspi3b -kernel /run/media/moritz/boot/kernel8.img -append "earlyprintk=ttyAMA0,115200 loglevel=8 console=ttyAMA0,115200" -dtb /run/media/moritz/boot/bcm2710-rpi-3-b.dtb -nographic

nix shell nixpkgs#python39Packages.binwalk-full
binwalk --extract /run/media/moritz/boot/kernel8.img


# https://kernel.googlesource.com/pub/scm/linux/kernel/git/mmarek/kbuild/+/lto/Documentation/lto-build

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

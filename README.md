
CONFIG_INITRAMFS_SOURCE=../rootfs.cpio.gz

CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=root=sr0



https://stackoverflow.com/questions/24583614/want-to-build-bare-linux-system-that-has-only-a-kernel-and-one-binary


sudo mount /dev/sdc1 /mnt/
sudo mkfs.fat -F32 /dev/sdc1
sudo fdisk /dev/sdc
sudo fdisk -l


mkdir -p /mnt/EFI/boot
cp arch/x86/boot/bzImage /mnt/EFI/boot/bootx64.efi


blkid | grep sdc


https://wiki.gentoo.org/wiki/EFI_stub_kernel
https://www.rodsbooks.com/efi-bootloaders/efistub.html




#include <stdio.h>
#include <unistd.h>

int main() {
    printf("FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR\n");
    sleep(0xFFFFFFFF);
    return 0;
}








gcc -static init.c -o init


make isoimage FDINITRD="$ROOTFS_PATH"
sudo dd if=arch/x86/boot/image.iso of=/dev/sdX

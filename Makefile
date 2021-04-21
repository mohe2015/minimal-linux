all: kernel program2 boot

program2:
	mkdir -p d/dev
	#cd d/dev && sudo mknod -m 622 console c 5 1 && sudo mknod -m 622 tty0 c 4 0
	aarch64-unknown-linux-gnu-gcc -Os -Wall -Wextra -static init.c -o d/init
	cd d && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz

program:
	mkdir -p d/dev
	cd d/dev && sudo mknod -m 622 console c 5 1 && sudo mknod -m 622 tty0 c 4 0
	aarch64-unknown-linux-gnu-as -o /tmp/init.o init.S
	aarch64-unknown-linux-gnu-ld -o d/init /tmp/init.o
	cd d && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz

kernel:
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git || true
	cd linux && make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- -j16

boot:
	qemu-system-aarch64 -M raspi3b -kernel linux/arch/arm64/boot/Image -dtb linux/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb -append console=ttyAMA0 -nographic -initrd rootfs.cpio.gz

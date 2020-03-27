all: program2 kernel

program2:
	mkdir -p d/dev
	cd d/dev && sudo mknod -m 622 console c 5 1 && sudo mknod -m 622 tty0 c 4 0
	gcc -static init.c -o d/init
	cd d  && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
	ROOTFS_PATH="$(pwd)/rootfs.cpio.gz"

program:
	mkdir -p d
	as --64 -o /tmp/init.o init.S
	ld -o d/init /tmp/init.o
	cd d && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
	ROOTFS_PATH="$(pwd)/rootfs.cpio.gz"

kernel:
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git || true
	#cd linux && make mrproper
	#cd linux && make defconfig
	cd linux && make -j8
	qemu-system-x86_64 -serial stdio -append "console=ttyS0" -kernel linux/arch/x86/boot/bzImage # -initrd "$ROOTFS_PATH"

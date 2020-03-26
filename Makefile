all: program kernel

program:
	mkdir -p d
	as --64 -o /tmp/init.o init.S
	ld -o d/init /tmp/init.o
	cd d && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
	ROOTFS_PATH="$(pwd)/rootfs.cpio.gz"

kernel:
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git || true
	#cd linux && make mrproper
	cd linux && make defconfig
	cd linux && make -j8
	qemu-system-x86_64 -kernel arch/x86/boot/bzImage # -initrd "$ROOTFS_PATH"

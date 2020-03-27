all: program2 kernel

program2:
	mkdir -p d/dev
	#cd d/dev && sudo mknod -m 622 console c 5 1 && sudo mknod -m 622 tty0 c 4 0
	gcc -Os -Wall -Wextra  init.c -o d/init
	ldd d/init
	readelf --all d/init
	mkdir -p d/usr/lib/
	cp /usr/lib/libc.so.6 d/usr/lib/
	mkdir -p d/lib64/
	cp /lib64/ld-linux-x86-64.so.2 d/lib64/
	
	
	cd d  && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz
	ROOTFS_PATH="$(pwd)/rootfs.cpio.gz"

program:
	mkdir -p d
	as --64 -o /tmp/init.o init.S
	ld -o d/init /tmp/init.o
	cd d && find . | cpio -o -H newc | gzip > ../rootfs.cpio.gz

kernel:
#	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git || true
	#cd linux && make mrproper
	#cd linux && make defconfig
#	cd linux && make -j8
	qemu-system-x86_64 -serial stdio -append "console=ttyS0" -kernel linux/arch/x86/boot/bzImage -initrd "rootfs.cpio.gz" -enable-kvm

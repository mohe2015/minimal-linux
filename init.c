#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main() {
    int onefd = open("/dev/console", O_RDONLY, 0);
    dup2(onefd, 0); // stdin
    int twofd = open("/dev/console", O_RDWR, 0);
    dup2(twofd, 1); // stdout
    dup2(twofd, 2); // stderr

    if (onefd > 2) close(onefd);
    if (twofd > 2) close(twofd);

    printf("FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR\n");
    sleep(0xFFFFFFFF);
    return 0;
}

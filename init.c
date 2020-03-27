#include <stdio.h>
#include <unistd.h>

int main() {
    int testInteger;
    printf("Enter an integer: ");
    scanf("%d", &testInteger);  
    printf("Number = %d\n", testInteger);
    
    sleep(0xFFFFFFFF);
    return 0;
}

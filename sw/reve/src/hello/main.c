#include "stdio.h"
int main(void) {
    init_uart(26);
    printfdbg("Hello World from Reve!\r\n");
	while(1){}
} 
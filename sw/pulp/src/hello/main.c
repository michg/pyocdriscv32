#include <stdio.h>

int main(void) {
  uart_set_cfg(0,(27*16+1));    //50Mhz:27*16+1, 25Mhz: 13*16+1
  printfdbg("Hello World from Pulp!\r\n");
} 
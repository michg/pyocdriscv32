#include <stdarg.h>
#include <math.h>
#include <stdio.h>
#include "printf.h"
#include "printf_cfg.h"


float b = 0.123;
float c;
int main(void) {
	uart_set_cfg(0,(13*16+1));    //50Mhz:27*16+1, 25Mhz: 13*16+1 
	printf("Uartinit done!\r\n");
	c = cosh(b);
	printf("cosh(%f) = %f\n", b, c);
	c = log(b);
	printf("log(%f) = %f\n", b, c);
	c = sin(b);
	printf("sin(%f) = %f\n", b, c);
	c = exp(b);
	printf("exp(%f) = %f\n", b, c);
	c = sqrt(b);
	printf("sqrt(%f) = %f\n", b, c);
	while(1){}
} 
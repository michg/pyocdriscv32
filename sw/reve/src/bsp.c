
typedef struct uart{
unsigned int status;
unsigned int brg;
unsigned int config;
unsigned int holding;

} UART;

UART* uart1 = (UART*)(0x103000);

void bsp_putc(char c)
{
    while(uart1->status & 0x100);
    uart1->holding = c;
}

void init_uart(unsigned int val)
{
    uart1->brg = val;
}


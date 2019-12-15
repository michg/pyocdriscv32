
typedef struct uart{
int dr;
int sr;
int ack;
} UART;

UART* uart1 = (UART*)(0xF0010000);

void bsp_putc(char c)
{
    while(((uart1->sr>>16)& 0xff)==0);
    uart1->dr = c;
}
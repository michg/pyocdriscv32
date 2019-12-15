#include <uart_pulp.h>

void uart_set_cfg(int parity, unsigned short clk_counter) {
  unsigned int i;    
  *(volatile unsigned int*)(UART_REG_LCR) = 0x87; //sets 8N1 and set DLAB to 1
  *(volatile unsigned int*)(UART_REG_DLM) = (clk_counter >> 8) & 0xFF;
  *(volatile unsigned int*)(UART_REG_DLL) =  clk_counter       & 0xFF;
  *(volatile unsigned int*)(UART_REG_FCR) = 0xA7; //enables 16byte FIFO and clear FIFOs
  *(volatile unsigned int*)(UART_REG_LCR) = 0x07; //sets 8N1 and set DLAB to 0

  //*(volatile unsigned int*)(UART_REG_IER) = ((*(volatile unsigned int*)(UART_REG_IER)) & 0xF0) | 0x02; // set IER (interrupt enable register) on UART
}

char uart_getchar() {
  while((*((volatile int*)UART_REG_LSR) & 0x1) != 0x1);

  return *(volatile int*)UART_REG_RBR;
}

void uart_sendchar(const char c) {
  // wait until there is space in the fifo
  while( (*(volatile unsigned int*)(UART_REG_LSR) & 0x20) == 0);

  // load FIFO
  *(volatile unsigned int*)(UART_REG_THR) = c;
}

void puti(int i)
{
    int b=0;
    int c=0;

    for (b = 28; b >= 0; b = b - 4)
    {
        c = (i >> b) & 0xF;
        if (c < 10)
        {
            uart_sendchar( 48 + c );
        }
        else
        {
            uart_sendchar( 65 - 10 + c );
        }
    }

    uart_sendchar(10); // Newline!
} 
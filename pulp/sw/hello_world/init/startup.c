/**
 * RISC-V bootup test
 * Author: Daniele Lacamera <root@danielinux.net>
 * Modified by: Anderson Ignacio <anderson@aignacio.com>
 *
 * MIT License
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdint.h>
#include "encoding.h"
#include "riscv_soc_utils.h"

extern void trap_entry(void);
extern void trap_exit(void);

extern uint32_t  _start_vector;
extern uint32_t  _stored_data;
extern uint32_t  _start_data;
extern uint32_t  _end_data;
extern uint32_t  _start_bss;
extern uint32_t  _end_bss;
extern uint32_t  _start_stack;
extern uint32_t  _end_stack;
extern uint32_t  _start_heap;
extern uint32_t  _end_heap;
extern uint32_t  __global_pointer$;

extern void main(void);

void __attribute__((naked,__section__(".init"))) _start(void) {

    asm volatile("la gp, __global_pointer$");
    asm volatile("la sp, _start_stack");

    /* Set up vectored interrupt, with starting at offset 0x100 */
    asm volatile("csrw mtvec, %0":: "r"((uint8_t *)(&_start_vector) + 1));

    // register uint32_t *src, *dst;

    // src = (uint32_t *) &_stored_data;
    // dst = (uint32_t *) &_start_data;

    // /* Copy the .data section from flash to RAM. */
    // while (dst < (uint32_t *)&_end_data) {
    //     *dst = *src;
    //     dst++;
    //     src++;
    // }

    // /* Initialize the BSS section to 0 */
    // dst = &_start_bss;
    // while (dst < (uint32_t *)&_end_bss) {
    //     *dst = 0U;
    //     dst++;
    // }

    main();
}

void __attribute__((weak)) isr_synctrap(void) {
    static uint32_t synctrap_cause = 0;
    asm volatile("csrr %0,mcause" : "=r"(synctrap_cause));
    asm volatile("ebreak");
}

void __attribute__((weak)) isr_m_external(void) {
    write_csr(mip, (0 << IRQ_M_EXT));
    return;
    while(1);
}

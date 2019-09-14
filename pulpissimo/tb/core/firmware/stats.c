// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

#include "firmware.h"

static void stats_print_dec(unsigned int val, int digits, bool zero_pad)
{
    char buffer[32];
    char *p = buffer;
    while (val || digits > 0) {
	if (val)
	    *(p++) = '0' + val % 10;
	else
	    *(p++) = zero_pad ? '0' : ' ';
	val = val / 10;
	digits--;
    }
    while (p != buffer) {
	if (p[-1] == ' ' && p[-2] == ' ')
	    p[-1] = '.';
	print_chr(*(--p));
    }
}

void init_stats(void)
{
    /* enable INSTR anc CYCLE counter */
    /* TODO: this is still buggy */
    unsigned int mask = 3;
    __asm__ volatile("csrw 0x7A1, %0" ::"r"(mask));
}

void stats(void)
{
    unsigned int num_cycles, num_instr;
    /* ideally we could use this */
    // __asm__ volatile ("rdcycle %0; rdinstret %1;" : "=r"(num_cycles),
    // "=r"(num_instr));
    /* riscy specific */
    __asm__ volatile("csrr %0, 0x780" : "=r"(num_cycles));
    __asm__ volatile("csrr %0, 0x781" : "=r"(num_instr));
    print_str("Cycle counter ........");
    stats_print_dec(num_cycles, 8, false);
    print_str("\nInstruction counter ..");
    stats_print_dec(num_instr, 8, false);
    print_str("\nCPI: ");
    stats_print_dec((num_cycles / num_instr), 0, false);
    print_str(".");
    stats_print_dec(((100 * num_cycles) / num_instr) % 100, 2, true);
    print_str("\n");
}

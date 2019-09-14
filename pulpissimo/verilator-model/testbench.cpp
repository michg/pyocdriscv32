// Copyright 2017 Embecosm Limited <www.embecosm.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Simple Verilator model test bench
// Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
// Contributor Graham Markall <graham.markall@embecosm.com>

#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include "Vtop__Syms.h"
#include "Vtop__Dpi.h"


#include <iostream>
#include <cstdint>
#include <cstdlib>
#include <stdio.h>

using std::cout;
using std::cerr;
using std::endl;

// Count of clock ticks

static vluint64_t  cpuTime = 0;


static uint64_t mCycleCnt = 0;
static int trace = 0; 

Vtop *cpu;
VerilatedVcdC * tfp;

// Clock the CPU for a given number of cycles, dumping to the trace file at
// each clock edge.
void clockSpin(uint32_t cycles)
{
  for (uint32_t i = 0; i < cycles; i++)
  {
      cpu->clk_i = 0;
      cpu->eval ();
      cpuTime += 5;
      if(trace) tfp->dump (cpuTime);
      cpu->clk_i = 1;
      cpu->eval ();
      cpuTime += 5;
      if(trace) tfp->dump (cpuTime);
      mCycleCnt++;
  }
}



// Single-step the CPU

void loadProgram(char* filename)
{
  uint32_t addr = 0x0;
  FILE *file;
  int c;
  file = fopen(filename, "rb");  
  while ((c = fgetc(file)) != EOF) {
		cpu->top->mm_ram_i->dp_ram_i->writeByte (addr, c);
		addr++;
	}
  printf("Read %x bytes\n",addr);
  fclose(file);
}

int
main (int    argc,
      char * argv[])
{
  Verilated::commandArgs(argc, argv);
  // Instantiate the model
  cpu = new Vtop;

  // Open VCD  
  if(argc==3 && strcmp(argv[2],"vcd")==0) trace = 1; 
  Verilated::traceEverOn (true);
  tfp = new VerilatedVcdC;
  cpu->trace (tfp, 99);
  if(trace) tfp->open ("model.vcd");

  // Fix some signals for now.
  cpu->fetch_enable_i = 0;

  // Cycle through reset
  cpu->rst_ni = 0;
  clockSpin(5);
  cpu->rst_ni = 1;

  // Put a few instructions in memory
  loadProgram(argv[1]);
   cout << "About to halt and set traps on exceptions" << endl;

  clockSpin(5);

  cpu->fetch_enable_i = 1;

  cout << "Cycling clock to run for a few instructions" << endl;
  while(1) 
	clockSpin(1000);
   
  // Close VCD
  if(trace) tfp->close ();
  // Tidy up
  delete tfp;
  delete cpu;

}

//! Function to handle $time calls in the Verilog

double
sc_time_stamp ()
{
  return cpuTime;

}

// Local Variables:
// mode: C++
// c-file-style: "gnu"
// show-trailing-whitespace: t
// End:

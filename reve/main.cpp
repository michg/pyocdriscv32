#include "Vtop.h"
#include "Vtop__Syms.h"

 
#include "verilated.h"

#ifdef FST
    #include "verilated_fst_c.h" 
#else
    #include "verilated_vcd_c.h"
#endif

#include "../simframework/framework.h"
#include "../simframework/jtag.h"
Workspace<Vtop> *murax;

class MuraxWorkspace : public Workspace<Vtop>{
public:
	MuraxWorkspace(int vcd) : Workspace("Murax", vcd){
		ClockDomain *mainClk = new ClockDomain(&top->clk,NULL,20,300);
		AsyncReset *asyncReset = new AsyncReset(&top->reset_n, 500, 1);
		

		timeProcesses.push_back(mainClk);
		timeProcesses.push_back(asyncReset);

		Jtag *jtag = new Jtag(&top->jtag_tms,&top->jtag_tdi,&top->tdo,&top->jtag_tck,83*4);
		timeProcesses.push_back(jtag);

	}
};


struct timespec timer_start(){
    struct timespec start_time;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start_time);
    return start_time;
}

long timer_end(struct timespec start_time){
    struct timespec end_time;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end_time);
    uint64_t diffInNanos = end_time.tv_sec*1e9 + end_time.tv_nsec -  start_time.tv_sec*1e9 - start_time.tv_nsec;
    return diffInNanos;
}



int main(int argc, char **argv, char **env) {
    int vcd=0; 
	Verilated::randReset(2);
	Verilated::commandArgs(argc, argv);
    if(argc==2 && strcmp(argv[1],"vcd")==0) vcd = 1;
	printf("BOOT\n");
	timespec startedAt = timer_start();

	murax  = new MuraxWorkspace(vcd);
	murax->run(100e6);

	uint64_t duration = timer_end(startedAt);
	cout << endl << "****************************************************************" << endl;
	cout << "Had simulate " << workspaceCycles << " clock cycles in " << duration*1e-9 << " s (" << workspaceCycles / (duration*1e-9) << " Khz)" << endl;
	cout << "****************************************************************" << endl << endl;


	exit(0);
}

double sc_time_stamp ()
{ double tmp;
  tmp=murax->gettime();
  printf("%d\n",tmp);
  return tmp;

} 

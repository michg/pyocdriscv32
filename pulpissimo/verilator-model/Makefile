DEBUG?=no
TRACE?=no
FST?=no
PRINT_PERF?=no
TRACE_START=0


VINC = ../rtl/include
VINC2 = ../fpnew/src/common_cells/include

VERILATOR_ARGS += -trace-structs
ADDCFLAGS += -CFLAGS -DTRACE

ifeq ($(FST),yes)
    VERILATOR_ARGS += --trace-fst
    ADDCFLAGS += -CFLAGS "-DFST"
endif
ifneq ($(FST),yes)
    VERILATOR_ARGS += --trace
endif
ifeq ($(DEBUG),yes)
	ADDCFLAGS += -CFLAGS "-g3 -O0"
endif
ifneq ($(DEBUG),yes)
	ADDCFLAGS += -CFLAGS "-O3"
endif
ifeq ($(PRINT_PERF),yes)
	ADDCFLAGS += -CFLAGS -DPRINT_PERF
endif

ADDCFLAGS += -CFLAGS -DTRACE_START=${TRACE_START}



all: clean compile

run: compile
	./obj_dir/VMurax

verilate:
	verilator -cc  -I$(VINC) -I$(VINC2) -f vlist.txt -CFLAGS -std=gnu++11  ${ADDCFLAGS}  ${VERILATOR_ARGS} -Wno-WIDTH -Wno-UNOPTFLAT -Wno-BLKANDNBLK -Wno-fatal --x-assign unique  --top-module top  --exe main.cpp

compile: verilate
	make  -j  -C obj_dir/ -f Vtop.mk Vtop
 	
clean:
	rm -rf obj_dir
 	

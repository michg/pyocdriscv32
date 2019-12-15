
  ;/* stack initilization */
  lui x2, 0x1  

main_entry:
  ;/* jump to main program entry point (argc = argv = 0) */  
  addi x10, x0, 0
  addi x11, x0, 0
  global main
  jal x1, main
  ebreak

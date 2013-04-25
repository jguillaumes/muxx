// #include <string.h>
#include "kernfuncs.h"
#include "externals.h"

void panic(char *) __attribute__ ((noreturn));

void panic(char *msg) {
  int i=0;

  setpl7();                       // No interrupts while dying
  kprintf("System panic!\n%s\n*** Last saved frame:\n",msg) ;
  muxx_dumpctcb();
  kprintf("\n*** TCBT information:\n");
  for(i=0;i<MAX_TASKS;i++) {
    if (tct->tctTable[i].pid != 0) {
      muxx_dumptcb(&(tct->tctTable[i]));
      muxx_dumpmmu(&(tct->tctTable[i].mmuState));
    }
  }
  muxx_dumpmemsvc();
  kprintf("\n*** Halting system...\n");
  asm("halt");
  asm("halt");
  asm("halt");
 loop:
  goto loop;
}

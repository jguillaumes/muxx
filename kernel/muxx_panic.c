#include <string.h>
#include "kernfuncs.h"
#include "externals.h"

void panic(char *) __attribute__ ((noreturn));

void panic(char *msg) {
  int i=0;

  setpl7();                       // No interrupts while dying
  kputstrzl("System panic!") ;
  kputstrzl(msg);
  kputstrl("\r\n*** Last saved frame:",17);
  muxx_dumpctcb();
  kputstrzl("\r\n*** TCBT information:");
  for(i=0;i<MAX_TASKS;i++) {
    if (tct->tctTable[i].pid != 0) {
      muxx_dumptcb(&(tct->tctTable[i]));
      muxx_dumpmmu(&(tct->tctTable[i].mmuState));
    }
  }
  muxx_dumpmemsvc();
  kputstrzl("\r\n*** Halting system...");
  asm("halt");
  asm("halt");
  asm("halt");
 loop:
  goto loop;
}

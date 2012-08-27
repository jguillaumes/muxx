#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "externals.h"
#include "kernfuncs.h"
#include "muxxlib.h"

void muxx_dumpregs(CPUSTATE *cpus) {
  char cword[6];
  char *lastc = &(cword[5]);
  WORD *ptrreg;
  WORD w;


  int i=0;

  ptrreg = (WORD *) cpus;

  kprintf("\n");

  kprintf(" R0=%o, R1=%o, R2=%o, R3=%o\n",
	  ptrreg[0], ptrreg[1], ptrreg[2], ptrreg[3]);

  kprintf(" R4=%o, R5=%o, SP=%o, PC=%o\n",
	  ptrreg[4], ptrreg[5], ptrreg[6], ptrreg[7]);

  kprintf("PSW=%o,USP=%o,SSP=%o,KSP=%o\n",
	  ptrreg[8], ptrreg[9], ptrreg[10], ptrreg[11]);

  w = (cpus->psw) >> 14;
  itoo(w,cword);
  kputstrz(" CM:"); kputstr(lastc,1);
  w = (cpus->psw & 0x3000) >> 12;  
  itoo(w,cword);
  kputstrz(" PM:"); kputstr(lastc,1);
  w = (cpus->psw & 0x00E0) >> 5;  
  itoo(w,cword);
  kputstrz(" IPL:"); kputstr(lastc,1);
  if ((cpus->psw & 0x0001) != 0) {
    kputstr(" C+",3);
  } else {
    kputstr(" C-",3);
  }
  if ((cpus->psw & 0x0002) != 0) {
    kputstr(" V+",3);
  } else {
    kputstr(" V-",3);
  }
  if ((cpus->psw & 0x0004) != 0) {
    kputstr(" Z+",3);
  } else {
    kputstr(" Z-",3);
  }
  if ((cpus->psw & 0x0008) != 0) {
    kputstr(" N+",3);
  } else {
    kputstr(" N-",3);
  }
  if ((cpus->psw & 0x0010) != 0) {
    kputstrl(" T+",3);
  } else {
    kputstrl(" T-",3);
  }
}

void muxx_dumptcbregs() {
  muxx_dumpregs(&(curtcb->cpuState));
}


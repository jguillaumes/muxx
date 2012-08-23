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

  static char nregs[12][6]={"  R0=",", R1=",", R2=",", R3=","  R4=",", R5=",", SP=",", PC="," PSW=",",USP=",",SSP=",",KSP="};
  int i=0;

  ptrreg = (WORD *) cpus;

  kputstrzl(" ");

  for (i=0;i<4;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrzl(" ");
  for (i=4;i<8;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrzl(" ");
  for (i=8;i<12;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrzl(" ");

  w = (cpus->psw) >> 14;
  otoa(w,cword);
  kputstrz(" CM:"); kputstr(lastc,1);
  w = (cpus->psw & 0x3000) >> 12;  
  otoa(w,cword);
  kputstrz(" PM:"); kputstr(lastc,1);
  w = (cpus->psw & 0x00E0) >> 5;  
  otoa(w,cword);
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


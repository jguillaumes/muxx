#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "externals.h"

void dumpregs(CPUSTATE *cst) {
  char cword[6];
  WORD *ptrreg;

  static char nregs[12][6]={"  R0=",", R1=",", R2=",", R3=","  R4=",", R5=",", SP=",", PC="," PSW:",",USP:",",SSP:",",KSP:"};
  int i=0;
  kputstrl("",0);
  ptrreg = (WORD *) cst;

  for (i=0;i<4;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrl("",0);
  for (i=4;i<8;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrl("",0);
  for (i=8;i<12;i++) {
    kputstr(nregs[i],5);
    otoa(ptrreg[i],cword);
    kputstr(cword,6);
  }
  kputstrl("",0);
}

void dumptcbregs() {
  PTCB tcb;
  tcb = curtcb;

  dumpregs(&(tcb->cpuState));
}

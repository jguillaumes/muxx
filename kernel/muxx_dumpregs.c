#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "externals.h"

void muxx_dumpregs() {
  char cword[6];
  WORD *ptrreg;

  static char nregs[12][6]={"  R0=",", R1=",", R2=",", R3=","  R4=",", R5=",", SP=",", PC="," PSW:",",USP:",",SSP:",",KSP:"};
  int i=0;

  kputstrzl(" ");

  ptrreg = (WORD *) &(curtcb->cpuState);

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
}

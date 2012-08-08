#include "types.h"
#include "muxxdef.h"


void dumpregs(WORD *regs) {
  char cword[6];
  WORD *ptrreg;
  static char nregs[8][5]={" R0=",",R1=",",R2=",",R3="," R4=",",R5=",",SP=",",PC="};
  int i=0;
  kputstrl("",0);
  ptrreg = regs;
  for (i=0;i<4;i++) {
    kputstr(nregs[i],4);
    otoa(*ptrreg++,cword);
    kputstr(cword,6);
  }
  kputstrl("",0);
  for (i=4;i<8;i++) {
    kputstr(nregs[i],4);
    otoa(*ptrreg++,cword);
    kputstr(cword,6);
  }
  kputstrl("",0);
}

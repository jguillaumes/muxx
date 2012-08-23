#include "kernfuncs.h"
#include "muxxlib.h"
#include "muxx.h"

void muxx_dumpmmu(MMUSTATE *mmu) {
  int i=0;

  kputstrzl("Saved MMU status:");
  kputstrzl("User mode PARs/PDRs: ");
  for (i=0;i<8;i++) {
    kputstr("\t",1); 
    kputoct(mmu->upar[i]); kputstr("-",1); kputoct(mmu->updr[i]);
    kputstrl(" ",1);
  }
  kputstrl(" ",1);

#if CPU_HAS_SUPER == 1
  kputstrzl("Supervisor mode PARs/PDRs: ");
  for (i=0;i<8;i++) {
    kputstr("\t",1); 
    kputoct(mmu->spar[i]); kputstr("-",1); kputoct(mmu->spdr[i]);
    kputstrl(" ",1);
  }
  kputstrl(" ",1);
#else
  kputstrzl("Supervisor mode support not configured.\n\r");
#endif
  kputstrzl("Kernel mode PARs/PDRs: ");
  for (i=0;i<8;i++) {
    kputstr("\t",1) ;
    kputoct(mmu->kpar[i]); kputstr("-",1); kputoct(mmu->kpdr[i]);
    kputstrl(" ",1);
  }
  kputstrl(" ",1);
}


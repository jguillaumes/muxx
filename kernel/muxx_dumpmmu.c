#include "kernfuncs.h"
#include "muxxlib.h"
#include "muxx.h"
#include "externals.h"

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

void muxx_dumpmemsvc() {
  int i;
  kputstrzl("\r\n*** Memory Management Control Blocks (MMCBs):");
  for(i=0;i<MEM_NMCBS; i++) {
    if (mmcbtaddr->mmcbt[i].ownerPID != -1) {
      kputstrz(" MMCB="); kputoct((WORD) &(mmcbtaddr->mmcbt[i]));
      kputstrz(" ADDR="); kputoct(mmcbtaddr->mmcbt[i].blockAddr);
      kputstrz(" SIZE="); kputoct(mmcbtaddr->mmcbt[i].blockSize);  
      if (mmcbtaddr->mmcbt[i].ownerPID == 0) {
	kputstrz(" OWNR="); kputstrz("*FREE*");  
	kputstrz(" PAGE="); kputstrz("*NONE*");  
      } else {
	kputstrz(" OWNR="); kputoct(mmcbtaddr->mmcbt[i].ownerPID);  
	kputstrz(" PAGE="); kputoct(mmcbtaddr->mmcbt[i].ownerPAR);
      }

      kputstrz(" NEXT="); kputoct((WORD) mmcbtaddr->mmcbt[i].nextBlock);
      kputstrz(" PREV="); kputoct((WORD) mmcbtaddr->mmcbt[i].prevBlock);
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.sharedBlock) {
	kputstrz(" SHR");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.fixedBlock) {
	kputstrz(" FIX");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.privBlock) {
	kputstrz(" PRV");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.iopage) {
	kputstrz(" IO ");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.stack) {
	kputstrz(" STK");
      }
      kputstrl(" ",1);
    }
  }
  kputstrzl("---");
}

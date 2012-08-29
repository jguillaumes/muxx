#include "kernfuncs.h"
#include "muxxlib.h"
#include "muxx.h"
#include "externals.h"

void muxx_dumpmmu(MMUSTATE *mmu) {
  int i=0;

  kprintf("\nSaved MMU status:\n");
#if CPU_HAS_SUPER != 1
  kprintf("USER\t\t\tKERNEL\n");
  for (i=0;i<8;i++) {
    kprintf("%o-%o\t\t%o-%o\n", mmu->upar[i], mmu->updr[i],
	                        mmu->kpar[i], mmu->kpdr[i]);
  }
#else
  kprintf("USER\t\t\tSUPER\t\t\tKERNEL\n");
  for (i=0;i<8;i++) {
    kprintf("%o-%o\t\t%o-%o\n", mmu->upar[i], mmu->updr[i],
	                        mmu->spar[i], mmu->spdr[i],
	                        mmu->kpar[i], mmu->kpdr[i]);
  }
#endif
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

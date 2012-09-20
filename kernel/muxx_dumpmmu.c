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
  kprintf("\n*** Memory Management Control Blocks (MMCBs):\n");
  for(i=0;i<MEM_NMCBS; i++) {
    if (mmcbtaddr->mmcbt[i].ownerPID != -1) {
      kprintf(" MMCB=%o ADDR=%o SIZE=%o",
	      &(mmcbtaddr->mmcbt[i]),mmcbtaddr->mmcbt[i].blockAddr,
	      mmcbtaddr->mmcbt[i].blockSize); 
      if (mmcbtaddr->mmcbt[i].ownerPID == 0) {
	kprintf(" OWNR=*FREE* PAGE=*NONE*");
      } else {
	kprintf(" OWNR=%o PAGE=%o",
		mmcbtaddr->mmcbt[i].ownerPID,
		mmcbtaddr->mmcbt[i].ownerPAR);
      }
      kprintf(" NEXT=%o PREV=%o", 
	     mmcbtaddr->mmcbt[i].nextBlock,
	     mmcbtaddr->mmcbt[i].prevBlock);
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.sharedBlock) {
	kprintf(" SHR");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.fixedBlock) {
	kprintf(" FIX");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.privBlock) {
	kprintf(" PRV");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.iopage) {
	kprintf(" IO ");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.stack) {
	kprintf(" STK");
      }
      if (mmcbtaddr->mmcbt[i].mmcbFlags.flags.iobuffer) {
	kprintf(" BUF");
      }
      kprintf("\n");
    }
  }
  kprintf("---\n");
}

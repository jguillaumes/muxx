#include <string.h>
#include "config.h" 
#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"

static findFreeMMCB();               // Forward declaration


/*
** Get free memory.
** This procedure finds a block of contiguous, free memory, marks it as 
** allocated to a PID and maps it into the TCB PAR registers.
** 
** The routine DOES NOT set up the real PARs
*/
WORD muxx_mem_getblock(WORD owner, WORD numBlocks, WORD flags, WORD page) {
  PMMCBT pmmcbt = mmcbtaddr;
  PMMCB  first = &(pmmcbt->mmcbt[0]); // First element of array is first in list
  PMMCB  cur = NULL, new=NULL;
  int found = 0;
  int numMMCB = 0;
  int curPL = 0;

  if (numBlocks > 128) return (EINVVAL);
  cur = first;

  curPL = setpl7();

  do {
    if (cur->blockSize >= numBlocks) 
      found = 1;
    else
      cur = cur->nextBlock;
  } while(cur != NULL && found == 0);
  if (cur == NULL) return(ENOMEM);
  
  numMMCB = findFreeMMCB();
  if (numMMCB == 0) return (ENOMEM);

  new = &pmmcbt->mmcbt[numMMCB];
  cur->blockSize -= numBlocks;
  new->blockSize = numBlocks;
  new->blockAddr = cur->blockAddr;
  cur->blockAddr += numBlocks;

  new->ownerPID = owner;
  new->ownerPAR = page;
  new->prevBlock = cur;
  if (cur->nextBlock != NULL) {
    cur->nextBlock->prevBlock = new;
  }
  cur->nextBlock = new;
  new->nextBlock = cur->nextBlock;
  new->mmcbFlags.word = flags;

  setpl(curPL);

  return (EOK);
}

/*
** Initialize MMCBs and explicitly mark initial memory as used
** 
** This routine is used by the kernel to tell the memory manager about
** the memory it allocated during startup, before the memory manager was
** running.
** 
*/
int muxx_mem_init() {
  int i = 0;
  PMMCBT pmmcbt = mmcbtaddr;

  memset((void *) pmmcbt ,0 ,sizeof(MMCBT));
  memcpy(pmmcbt->mcbeye, "MMCBT---",8);
  pmmcbt->numEntries = MEM_NMCBS;

  for (i=0; i<MEM_NMCBS; i++) {
    pmmcbt->mmcbt[i].ownerPID = -1; // Unallocated MMCB
  }

  /*
  ** First two memory chunks: physical blocks 0-255 mapped to the first two PARs
  */
  pmmcbt->mmcbt[0].blockAddr = 0;     // Base of physical memory
  pmmcbt->mmcbt[0].blockSize = 0200;
  pmmcbt->mmcbt[0].ownerPID = 1;
  pmmcbt->mmcbt[0].ownerPAR = 0;
  pmmcbt->mmcbt[0].prevBlock = NULL;
  pmmcbt->mmcbt[0].nextBlock = &(pmmcbt->mmcbt[1]);
  pmmcbt->mmcbt[0].mmcbFlags.flags.sharedBlock = 1;
  pmmcbt->mmcbt[0].mmcbFlags.flags.fixedBlock = 1;
  pmmcbt->mmcbt[0].mmcbFlags.flags.privBlock = 1;
  pmmcbt->mmcbt[0].mmcbFlags.flags.iopage = 0;

  pmmcbt->mmcbt[1].blockAddr = 0200;     // Next block of physical memory
  pmmcbt->mmcbt[1].blockSize = 0200;
  pmmcbt->mmcbt[1].ownerPID = 1;
  pmmcbt->mmcbt[1].ownerPAR = 1;
  pmmcbt->mmcbt[1].prevBlock = &(pmmcbt->mmcbt[0]);
  pmmcbt->mmcbt[1].nextBlock = &(pmmcbt->mmcbt[2]);
  pmmcbt->mmcbt[1].mmcbFlags.flags.sharedBlock = 1;
  pmmcbt->mmcbt[1].mmcbFlags.flags.fixedBlock = 1;
  pmmcbt->mmcbt[1].mmcbFlags.flags.privBlock = 1;
  pmmcbt->mmcbt[1].mmcbFlags.flags.iopage = 0;

  /*
  ** Stack block
  */
  pmmcbt->mmcbt[2].blockAddr = 0400;     // Next block of physical memory
  pmmcbt->mmcbt[2].blockSize = 0100;     // 4 KB for stack
  pmmcbt->mmcbt[2].ownerPID = 1;
  pmmcbt->mmcbt[2].ownerPAR = 6;         // Page 6, just below iospace
  pmmcbt->mmcbt[2].prevBlock = &(pmmcbt->mmcbt[1]);
  pmmcbt->mmcbt[2].nextBlock = &(pmmcbt->mmcbt[3]);
  pmmcbt->mmcbt[2].mmcbFlags.flags.sharedBlock = 0;
  pmmcbt->mmcbt[2].mmcbFlags.flags.fixedBlock = 0;
  pmmcbt->mmcbt[2].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[2].mmcbFlags.flags.iopage = 0;

  /*
  ** Free space
  */
  pmmcbt->mmcbt[3].blockAddr = 00500;    // Next block of physical memory
  pmmcbt->mmcbt[3].blockSize = 07500;    // Rest of physical up to 256K
  pmmcbt->mmcbt[3].ownerPID = 0;         // Unallocated         
  pmmcbt->mmcbt[3].ownerPAR = 0;         // Not mapped
  pmmcbt->mmcbt[3].prevBlock = &(pmmcbt->mmcbt[2]);
  pmmcbt->mmcbt[3].nextBlock = &(pmmcbt->mmcbt[4]);
  pmmcbt->mmcbt[3].mmcbFlags.flags.sharedBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.fixedBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.iopage = 0;

  /*
  ** IOSPACE mapping
  */
  pmmcbt->mmcbt[4].blockAddr = 07600;     // IOSPACE block
  pmmcbt->mmcbt[4].blockSize = 00200;     // 8 KB, architecture defined
  pmmcbt->mmcbt[4].ownerPID = 1;
  pmmcbt->mmcbt[4].ownerPAR = 7;         // Page 7, IOSPACE mapping
  pmmcbt->mmcbt[4].prevBlock = &(pmmcbt->mmcbt[3]);
  pmmcbt->mmcbt[4].nextBlock = NULL;
  pmmcbt->mmcbt[4].mmcbFlags.flags.sharedBlock = 1;
  pmmcbt->mmcbt[4].mmcbFlags.flags.fixedBlock = 1;
  pmmcbt->mmcbt[4].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[4].mmcbFlags.flags.iopage = 1; 
}

void muxx_mem_freeblock(WORD firstBlock, WORD blocks) {

}

static int findFreeMMCB() {
  PMMCBT pmmcbt = mmcbtaddr;
  int i=0;
  int found=0; 

  for (i=0; i<pmmcbt->numEntries && (!found) ; i++) {
    if (pmmcbt->mmcbt[i].ownerPID == 0) found = i;
  }
  return found;
}

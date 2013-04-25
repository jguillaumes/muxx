// #include <string.h>
#include "config.h" 
#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"
#include "spl.h"
#include "kernfuncs.h"

int findFreeMMCB();               // Forward declaration

/*
** Get free memory.
** This procedure finds a block of contiguous, free memory, marks it as 
** allocated to a PID and maps it into the TCB PAR registers.
** 
** The routine DOES NOT set up the real PARs
*/
PMMCB muxx_mem_getblock(PTCB owner, WORD numBlocks, WORD flags, WORD page) {
  PMMCBT pmmcbt = mmcbtaddr;
  PMMCB  first = &(pmmcbt->mmcbt[0]); // First element of array is first in list
  PMMCB  cur = NULL, new=NULL;
  int found = 0;
  int numMMCB = 0;

  // Check limit of blocks (128 = 8KB)
  if (numBlocks > 128) return (NULL);

  cur = first;                        // Start scan of MMCBT

  do {                                // Loop until we find a MMCB with
    if (cur->ownerPID == 0  &&        // Non-owned memory 
	cur->blockSize >= numBlocks)  // enough free memory
      found = 1;
    else
      cur = cur->nextBlock;           // Check next MMCB in the chain
  } while(cur != NULL && found == 0);

  if (cur == NULL) return(NULL);      // No luck: error
  
  numMMCB = findFreeMMCB();           // Find a free MMCB in the table
  if (numMMCB == 0) panic("PANIC2"); // return (NULL);    // If not, error

  new = &pmmcbt->mmcbt[numMMCB];      // Prepare new MMCB with the allocated
  cur->blockSize -= numBlocks;        // memory, and modify old MMCB with
  new->blockSize = numBlocks;         // the memory we are taking
  new->blockAddr = cur->blockAddr;
  cur->blockAddr += numBlocks;

  new->ownerPID = owner->pid;         // Establish ownership of new MMCB
  new->ownerPAR = page;
  new->prevBlock = cur;
  if (cur->nextBlock != NULL) {
    cur->nextBlock->prevBlock = new;
  }
  cur->nextBlock = new;               // Link new MMCB in the chain
  new->nextBlock = cur->nextBlock;
  new->mmcbFlags.word = flags;

  return (new);
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
  int i = 0, rc=0;
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
  pmmcbt->mmcbt[0].mmcbFlags.flags.stack = 0;

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
  pmmcbt->mmcbt[1].mmcbFlags.flags.stack = 0;

  pmmcbt->mmcbt[2].blockAddr = 0400;     // Next block of physical memory
  pmmcbt->mmcbt[2].blockSize = 0200;
  pmmcbt->mmcbt[2].ownerPID = 1;
  pmmcbt->mmcbt[2].ownerPAR = 2;
  pmmcbt->mmcbt[2].prevBlock = &(pmmcbt->mmcbt[1]);
  pmmcbt->mmcbt[2].nextBlock = &(pmmcbt->mmcbt[3]);
  pmmcbt->mmcbt[2].mmcbFlags.flags.sharedBlock = 1;
  pmmcbt->mmcbt[2].mmcbFlags.flags.fixedBlock = 1;
  pmmcbt->mmcbt[2].mmcbFlags.flags.privBlock = 1;
  pmmcbt->mmcbt[2].mmcbFlags.flags.iopage = 0;
  pmmcbt->mmcbt[2].mmcbFlags.flags.stack = 0;

  /*
  ** Stack block 
  */
  pmmcbt->mmcbt[3].blockAddr = 0600;     // Next block of physical memory
  pmmcbt->mmcbt[3].blockSize = 0100;     // 4 KB for stack
  pmmcbt->mmcbt[3].ownerPID = 1;
  pmmcbt->mmcbt[3].ownerPAR = 6;         // Page 6, just below iospace
  pmmcbt->mmcbt[3].prevBlock = &(pmmcbt->mmcbt[2]);
  pmmcbt->mmcbt[3].nextBlock = &(pmmcbt->mmcbt[4]);
  pmmcbt->mmcbt[3].mmcbFlags.flags.sharedBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.fixedBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.iopage = 0;
  pmmcbt->mmcbt[3].mmcbFlags.flags.stack = 1;

  /*
  ** Free space
  */
  pmmcbt->mmcbt[4].blockAddr = 00700;    // Next block of physical memory
  pmmcbt->mmcbt[4].blockSize = 07100;    // Rest of physical up to 256K
  pmmcbt->mmcbt[4].ownerPID = 0;         // Unallocated         
  pmmcbt->mmcbt[4].ownerPAR = 0;         // Not mapped
  pmmcbt->mmcbt[4].prevBlock = &(pmmcbt->mmcbt[3]);
  pmmcbt->mmcbt[4].nextBlock = &(pmmcbt->mmcbt[5]);
  pmmcbt->mmcbt[4].mmcbFlags.flags.sharedBlock = 0;
  pmmcbt->mmcbt[4].mmcbFlags.flags.fixedBlock = 0;
  pmmcbt->mmcbt[4].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[4].mmcbFlags.flags.iopage = 0;
  pmmcbt->mmcbt[4].mmcbFlags.flags.stack = 0;

  /*
  ** IOSPACE mapping
  */
  pmmcbt->mmcbt[5].blockAddr = 07600;     // IOSPACE block
  pmmcbt->mmcbt[5].blockSize = 00200;     // 8 KB, architecture defined
  pmmcbt->mmcbt[5].ownerPID = 1;
  pmmcbt->mmcbt[5].ownerPAR = 7;         // Page 7, IOSPACE mapping
  pmmcbt->mmcbt[5].prevBlock = &(pmmcbt->mmcbt[4]);
  pmmcbt->mmcbt[5].nextBlock = NULL;
  pmmcbt->mmcbt[5].mmcbFlags.flags.sharedBlock = 1;
  pmmcbt->mmcbt[5].mmcbFlags.flags.fixedBlock = 1;
  pmmcbt->mmcbt[5].mmcbFlags.flags.privBlock = 0;
  pmmcbt->mmcbt[5].mmcbFlags.flags.iopage = 1; 

  return rc;

}

/*
** Setup the shared memory space for a new task
*/
int muxx_setup_taskmem (PTCB task) {
  PMMCB mcb = NULL;
  int tsize=0;
  int ssize=0;
  int ttype=0;
  int rc = EOK;
  int i=0;
  WORD endalloc=0;
  WORD wpdr=0;
  WORD tucbsize = sizeof(struct TUCB_S);
  PTUCB ptucb = NULL;

  tucbsize = (tucbsize-1)/64;
  tucbsize = (tucbsize+1)*64;

  ttype = (task->taskType & 0000007);
  tsize = (task->taskType & 0000070);          // Extract task size
  ssize = (task->taskType & 0000700);          // Extract task size
  
  // Check combinations of task type, task size and stack sze
  if (ssize != TSZ_SMALLS) return EINVVAL;      // Right now stack size setting
			                       // is not supported
  
  switch(ttype) {
  case SYS_TASK:         // System tasks: any size is allowed
    break;
  case USR_TASK:         // User tasks: any size is allowed
    break;
  case DRV_TASK:         // Driver tasks: Big (TSZ_BIG) is not allowed
    if (tsize == TSZ_BIG) return EINVVAL;
    break;
  default:
    return EINVVAL;
  }


  /*
  ** Kernel common pages (0-2)
  */
  if (task->privileges.prvflags.operprv) {
    wpdr = PDR_ACC_RW | PDR_SIZ_8K;
  } else {
    wpdr = PDR_ACC_RO | PDR_SIZ_8K;
  }
  task->mmuState.upar[0] = 0;
  task->mmuState.updr[0] = wpdr;
  task->mmuState.kpar[0] = 0;
  task->mmuState.kpdr[0] = PDR_ACC_RW | PDR_SIZ_8K;
  task->mmuState.upar[1] = 0200;
  task->mmuState.updr[1] = wpdr;
  task->mmuState.kpar[1] = 0200;
  task->mmuState.kpdr[1] = PDR_ACC_RW | PDR_SIZ_8K;
  task->mmuState.upar[2] = 0400;
  task->mmuState.updr[2] = wpdr;
  task->mmuState.kpar[2] = 0400;
  task->mmuState.kpdr[2] = PDR_ACC_RW | PDR_SIZ_8K;

  /*
  ** Task private space
  */
  
  // First page, always present (page 3, 8KB)
  mcb = muxx_mem_getblock(task, 0200, 0, 3);
  if (mcb != NULL) {
    task->mmuState.upar[3] = mcb->blockAddr;
    task->mmuState.updr[3] = PDR_ACC_RW | PDR_SIZ_8K;
    task->mmuState.kpar[3] = mcb->blockAddr;
    task->mmuState.kpdr[3] = PDR_ACC_RW | PDR_SIZ_8K;
    endalloc = (WORD) 8192*4;
  } else {
    kprintf("Error allocating memory for page 3, PID %o\n", task);
    return (ENOMEM);
  }

  // Second page, present for TSS_MED processes, page 4 8KB
  if ((tsize == TSZ_MED) || (tsize == TSZ_BIG)) {
    mcb = muxx_mem_getblock(task, 0200, 0, 4);
    if (mcb != NULL) {
      task->mmuState.upar[4] = mcb->blockAddr;
      task->mmuState.updr[4] = PDR_ACC_RW | PDR_SIZ_8K;
      task->mmuState.kpar[4] = mcb->blockAddr;
      task->mmuState.kpdr[4] = PDR_ACC_RW | PDR_SIZ_8K;
      endalloc = (WORD) 8192*5;
    } else {
      kprintf("Error allocating memory for page 4, PID %o\n", task);
      return (ENOMEM);
    }
  }

  // Second page, present for TSS_BIG processes, page 5 8KB
  if (tsize == TSZ_BIG) {
    mcb = muxx_mem_getblock(task, 0200, 0, 5);
    if (mcb != NULL) {
      task->mmuState.upar[5] = mcb->blockAddr;
      task->mmuState.updr[5] = PDR_ACC_RW | PDR_SIZ_8K;
      task->mmuState.kpar[5] = mcb->blockAddr;
      task->mmuState.kpdr[5] = PDR_ACC_RW | PDR_SIZ_8K;
      endalloc = (WORD) 8192*6;
    } else {
      kprintf("Error allocating memory for page 5, PID %o\n", task);
      return (ENOMEM);
    }
  }

  /*
  ** Point to TUCB at the end of the allocated space
  ** We can't initialize the TUCB at this point because the
  ** memory for the new task has not been set up.
  ** The TUCB will be prepared by the task initialization code
  ** in crt0.
  **/
  ptucb = (PTUCB) (endalloc - tucbsize);
  task->taskTUCB = ptucb;

  /*
  ** Task stack space
  ** The stack size options should be evaluated and applied here
  ** Since the stack grows downward, the PAR contains Addr - Size 
  ** so the physical addresses are properly calculated without
  ** overlapping.
  **
  ** Example: Base virtual address: 0140000
  **          Top of stack:         0157777 (0120000 + 020000 - 1)
  **          Bottom of stack:      0150000 (0120000 + 010000 )
  **          PAR value:            0500
  **          Size:                 0100 (4K)
  **          Physical range:       060000:067777   
  */
  mcb = muxx_mem_getblock(task, 0100, MMCB_FLG_STK, 6);
  if (mcb != NULL) {
    task->mmuState.upar[6] = mcb->blockAddr-0100;
    task->mmuState.updr[6] = PDR_ACC_RW | PDR_SIZ_4K | PDR_DIR_DN;
    task->mmuState.kpar[6] = mcb->blockAddr-0100;
    task->mmuState.kpdr[6] = PDR_ACC_RW | PDR_SIZ_4K | PDR_DIR_DN;
  } else {
    return (ENOMEM);
  }

  /*
  ** IOspace block
  ** 
  ** Map to user mode only if privileged process
  */
  task->mmuState.kpar[7] = 07600;
  task->mmuState.kpdr[7] = PDR_ACC_RW | PDR_SIZ_8K;
  if (task->privileges.prvflags.ioprv || task->privileges.prvflags.operprv) {
    task->mmuState.upar[7] = 07600;
    task->mmuState.updr[7] = PDR_ACC_RW | PDR_SIZ_8K;
  } else if (task->privileges.prvflags.auditprv) {
    task->mmuState.upar[7] = 07600;
    task->mmuState.updr[7] = PDR_ACC_RO | PDR_SIZ_8K;
  } else {
    task->mmuState.upar[7] = 0;
    task->mmuState.updr[7] = PDR_ACC_NA | PDR_SIZ_0K;
  }

  /*
  ** Driver task (allocate 1KB at page 5 for buffer space)
  ** DRV_TASK can not be big, so the page 5 should always be free
  **
  */ 
  if (ttype == DRV_TASK) {
    mcb = muxx_mem_getblock(task, DRV_BUFSIZ/64, MMCB_FLG_BUF, 5);
    if (mcb != NULL) {
      task->mmuState.upar[4] = mcb->blockAddr;
      task->mmuState.updr[4] = PDR_ACC_RW | PDR_SIZ_1K;
      task->mmuState.kpar[4] = mcb->blockAddr;
      task->mmuState.kpdr[4] = PDR_ACC_RW | PDR_SIZ_1K;
    } else {
      return (ENOMEM);
    }
  }

  return (rc);
}


void muxx_mem_freeblock(WORD firstBlock, WORD blocks) {
  
}

int findFreeMMCB() {
  PMMCBT pmmcbt = mmcbtaddr;
  int i=0;
  int found=0; 

  for (i=0; (i < pmmcbt->numEntries) && (!found) ; i++) {
    if (pmmcbt->mmcbt[i].ownerPID == -1) found=i;
  }
  return found;
}

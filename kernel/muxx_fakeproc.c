#include <string.h>
#include "types.h"
#include "muxx.h"
#include "queues.h"
#include "muxxdef.h"
#include "externals.h"
#include "kernfuncs.h"

extern void *startup();

/*
** Build the TCB and the MMU status for the STARTUP process
*/

void muxx_fakeproc() {
  MMUSTATE *mmu;
  PTCB tcb = &(tct->tctTable[0]);
  
  memset(tcb,0,sizeof(TCB));
  memcpy(tcb->taskname,"STARTUP ",8);
  tcb->pid = 1;
  tcb->ppid = 0;
  tcb->uic = 1;
  topspid = 1;

  tcb->status = TSK_INIT;
  tcb->cpuState.pc  = (WORD) startup;
  tcb->cpuState.psw = (WORD) 0xC000;
  tcb->cpuState.sp  = (WORD) ustackt;
  tcb->cpuState.usp = (WORD) ustackt;
  tcb->cpuState.ksp = (WORD) kstackt;

  tcb->privileges.prvflags.operprv = 1;
  tcb->privileges.prvflags.ioprv = 1;
  tcb->privileges.prvflags.auditprv = 1;

  mmu = &(tcb->mmuState);
  memset((ADDRESS) mmu, 0, sizeof(TCB));

  mmu->upar[0] = 0;
  mmu->upar[1] = 0200;
  mmu->upar[2] = 0400;
  mmu->upar[6] = 0600-0100;   // Stack
  mmu->upar[7] = 07600; 
  mmu->kpar[0] = 0;
  mmu->kpar[1] = 0200;
  mmu->kpar[2] = 0400;
  mmu->kpar[6] = 0600-0100;   // Stack
  mmu->kpar[7] = 07600; 
  
  mmu->updr[0] = 0x7F06;  
  mmu->updr[1] = 0x7F06;  
  mmu->updr[2] = 0x7F06;  
  mmu->updr[6] = 0x400E;
  mmu->updr[7] = 0x7F04;
  mmu->kpdr[0] = 0x7F06;  
  mmu->kpdr[1] = 0x7F06;  
  mmu->kpdr[2] = 0x7F06;  
  mmu->kpdr[6] = 0x400E;
  mmu->kpdr[7] = 0x7F06;

  tcb->taskTUCB = 8192*3 - 64;

  curtcb = tcb;
}

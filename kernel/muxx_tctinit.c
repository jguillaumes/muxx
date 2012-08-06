#include <string.h>
#include "muxxdef.h"
#include "muxx.h"

static TCTA tctArea;


void muxx_tcbinit(PTCB tcb) {
  int j=0;

   tcb->pid  = 0;
    tcb->ppid = 0;
    tcb->uic  = 0L;
    tcb->status.stword = 0;
    tcb->privileges.prvword = 0;
    tcb->firstChild = 0;
    tcb->lastChild = 0;
    tcb->nextSibling = 0;
    for (j=0;j<6;j++) {
      tcb->regs[j] = 0;
    }
    tcb->usp = 0;
    tcb->ksp = 0;
    tcb->ssp = 0;
    tcb->pc  = 0;
    tcb->psw = 0;
    for (j=0;j<8;j++) {
      tcb->upar[j] = 0;
      tcb->spar[j] = 0;
      tcb->kpar[j] = 0;
    }
    tcb->clock_ticks = 0L;
    tcb->created_timestamp = 0L;
 
}


void muxx_tctinit() {
  int i=0;
  PTCB tcb;

  tct = &tctArea;
  tctsize = sizeof(tctArea);
  memcpy(tctArea.tcteye,"TCTAREA*",8);

  for (i=0;i<MAX_TASKS;i++) {
    tcb = &(tctArea.tctTable[i]);
    muxx_tcbinit(tcb);
  }
}


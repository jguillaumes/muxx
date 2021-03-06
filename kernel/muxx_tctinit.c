// #include <string.h>
#include "config.h"
#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"

extern TCTA tctArea;

void muxx_tcbinit(PTCB tcb) {

   tcb->pid  = 0;
    tcb->ppid = 0;
    tcb->uic  = 0L;
    tcb->status = TSK_INIT;
    tcb->flags.flword = 0;
    tcb->privileges.prvword = 0;
    tcb->firstChild = 0;
    tcb->lastChild = 0;
    tcb->nextSibling = 0;
    memset(&tcb->cpuState,0,sizeof(tcb->cpuState));
    memset(&tcb->mmuState,0,sizeof(tcb->mmuState));
    tcb->clockTicks = 0L;
    tcb->created_timestamp = 0L;
    tcb->taskTUCB = NULL;
}


void muxx_tctinit() {
  int i=0;
  PTCB tcb;

  // tct = &tctArea;
  tctsize = sizeof(tctArea);
  memcpy(tctArea.tcteye,"TCTAREA*",8);

  for (i=0;i<MAX_TASKS;i++) {
    tcb = &(tctArea.tctTable[i]);
    muxx_tcbinit(tcb);
  }
}

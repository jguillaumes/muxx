#include <string.h>
#include "types.h"
#include "muxx.h"
#include "queues.h"
#include "muxxdef.h"
#include "externals.h"

/*
** Build the TCB for the STARTUP process
*/

void muxx_fakeproc() {
  
  PTCB tcb = &(tct->tctTable[0]);  
  memset(tcb,0,sizeof(TCB));
  memcpy(tcb->taskname,"STARTUP ",8);
  tcb->pid = 1;
  tcb->ppid = 0;
  tcb->uic = 1;

  tcb->status = TSK_RUN;

  tcb->privileges.prvflags.operprv = 1;
  tcb->privileges.prvflags.ioprv = 1;
  
  curtcb = tcb;
}

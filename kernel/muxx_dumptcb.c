#include "types.h"
#include <strings.h>
#include "muxx.h"
#include "kernfuncs.h"
#include "muxxlib.h"
#include "config.h"
#include "externals.h"

void muxx_dumptcb(PTCB tcb) {
  int i=0;
  WORD *wptr=0,*wptru=0;

  if (tcb==NULL) tcb=curtcb;
  kprintf("\nTCB at address %o (", tcb);
  kputstr((char *)&(tcb->taskname),8); 
  kprintf(") PID   : %o \n", tcb->pid);

  kprintf ("Status: %o ", tcb->status);
  switch(tcb->status) {
  case TSK_INIT:
    kprintf("INIT");
    break;
  case TSK_READY:
    kprintf("READY");
    break;
  case TSK_BLOCKED:
    kprintf("BLOCKED");
    break;
  case TSK_RUN:
    kprintf("RUN");
    break;
  case TSK_SUSP:
    kprintf("SUSPENDED");
    break;
  case TSK_DISPOSE:
    kprintf("DISPOSE");
    break;
  default:
    kprintf("INVALID");
    break;
  }
  kprintf("\n");

  kprintf ("Flags : %o ", tcb->flags.flword);
  if (tcb->flags.flflags.sending)   kprintf("SENDING ");
  if (tcb->flags.flflags.receiving) kprintf("RECEIVING ");
  if (tcb->flags.flflags.suspended) kprintf("SUSPENDED ");
  if (tcb->flags.flflags.msgwait)   kprintf("MSGWAIT ");
  kprintf("\n");

  kprintf ("Privs : %o ", tcb->privileges.prvword);
  if (tcb->privileges.prvflags.operprv)  kprintf("OPERPRV ");
  if (tcb->privileges.prvflags.ioprv)    kprintf("IOPRV ");
  if (tcb->privileges.prvflags.auditprv) kprintf("AUDITPRV ");

  kprintf("\nType  : %o ", tcb->taskType);
  switch(tcb->taskType & 0000007) {
  case USR_TASK:
    kprintf("USER    ");
    break;
  case SYS_TASK:
    kprintf("SYSTEM  ");
    break;
  case DRV_TASK:
    kprintf("DRIVER  ");
    break;
  default:
    kprintf("INVALID ");
  }

  switch(tcb->taskType & 0000070) {
  case TSZ_SMALL:
    kprintf("SMALL ");
    break;
  case TSZ_MED:
    kprintf("MED   ");
    break;
  case TSZ_BIG:
    kprintf("BIG   ");
    break;
  default:
    kprintf("INVAL ");
  }

  switch(tcb->taskType & 0000700) {
  case TSZ_SMALLS:
    kprintf("SMALLS \n");
    break;
  case TSZ_MED:
    kprintf("MEDS   \n");
    break;
  case TSZ_BIG:
    kprintf("BIGS   \n");
    break;
  default:
    kprintf("INVAL  \n");
  }

  muxx_dumpregs(&(tcb->cpuState));
  kprintf("\n16 top Kernel/User stack words:\n");
  wptr = (WORD *) tcb->cpuState.ksp;
  wptru= (WORD *) tcb->cpuState.usp;
  kprintf("KERNEL\t\tUSER\n");
  for(i=0; i<15; i++) {
    if ((wptr+i) <= (WORD *) kstackt) {
      kprintf("%o: %o\t", (WORD) (wptr+i), *(wptr+i));
    } else {
      kprintf("\t\t");
    }
    if ((wptru+i) <= (WORD *) ustackt) {
      kprintf("%o: %o\t", (WORD) (wptru+i), *(wptru+i));
    } else {
      kprintf("\t\t");
    }
    kprintf("\n");
    // if ((wptru < (WORD *) ustackt) && (wptr < (WORD *) kstackt)) return;
  }
}

void muxx_dumpctcb() {
  muxx_dumptcb((PTCB) curtcb);
}

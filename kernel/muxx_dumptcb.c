#include "types.h"
#include <strings.h>
#include "muxx.h"
#include "kernfuncs.h"
#include "muxxlib.h"
#include "config.h"
#include "externals.h"

void muxx_dumptcb(PTCB tcb) {
  int i=0;
  WORD *wptr=0;

  if (tcb==NULL) tcb=curtcb;
  kputstrz("\n\rTCB at address ");
  kputoct((WORD) tcb);
  kputstrz(" (")      ; kputstrz((char *)&(tcb->taskname)); kputstrz(") ");
  kputstrz("PID   : "); kputoct(tcb->pid); kputstrl(" ",1);
  kputstrz("Status: "); kputoct(tcb->status); kputstrl(" ",1);
  kputstrz("Flags : "); kputoct(tcb->flags.flword); kputstrl(" ",1);
  kputstrz("Privs : "); kputoct(tcb->privileges.prvword); kputstrl(" ",1);
  kputstrz("Type  : "); kputoct(tcb->pid); kputstrl(" ",1);
  muxx_dumpregs(&(tcb->cpuState));
  kputstrzl("\r\n16 top Kernel stack words:");
  wptr = (WORD *) tcb->cpuState.ksp;
  for(i=0;i<15 && wptr <= (WORD *) kstackt;i++) {
    kputoct((WORD) wptr);
    kputstr(": ", 2);
    kputoct(*wptr++);
    kputstrl(" ",1);
  }
  kputstrzl("\r\n16 top User stack words:");
  wptr = (WORD *) tcb->cpuState.usp;
  for(i=0;i<15 && wptr <= (WORD *) ustackt;i++) {
    kputoct((WORD) wptr);
    kputstr(": ", 2);
    kputoct(*wptr++);
    kputstrl(" ",1);
  }
}

void muxx_dumpctcb() {
  muxx_dumptcb((PTCB) curtcb);
}

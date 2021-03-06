#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "config.h"
#include "externals.h"
#include "queues.h"
#include "kernfuncs.h"

void muxx_check_quantums();
void muxx_check_timers(); 
void muxx_clock_handler(void *fp) ;

/*
** PSW
** PC  (at interrupt)
** R0
** R1
** Points to PC at interrupt
** PC  (from clock_svc.s)
*/
void muxx_clock_handler(void *fp) {
  // WORD *psw = (WORD *) CPU_PSW;
  utimeticks++;                       // Increment global ticks

  if (curtcb != NULL) {               // Increment ticks for current task
    curtcb->clockTicks++;
  }

  if (--clkcountdown <= 0) {        // Check for quantum time expiration
    clkcountdown = clkquantum;      // Reset quantum timer
    muxx_check_quantums(fp);        // And check process queues, etc...
  }
  muxx_check_timers();              // Check outstanding timers
}

void muxx_check_quantums(void *fp) {
  // PTCB tcb = curtcb;

  if (readyq->count > 0) {
    setpl7();
    copytrapfp(fp);
    muxx_yield();
    muxx_schedule();
  }
}

void muxx_check_timers() {
}

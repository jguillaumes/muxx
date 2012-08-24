#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "config.h"
#include "externals.h"
#include "queues.h"
#include "kernfuncs.h"

void muxx_schedule() __attribute__ ((noreturn));

void muxx_schedule() {
  PTCB tcb = curtcb;
  
  tcb = muxx_qGetTask(readyq);
  curtcb = tcb;
  // muxx_dumptcb(tcb);
  muxx_switch();
  panic("Switch didn't switch");
}

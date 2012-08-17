#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "config.h"
#include "externals.h"
#include "queues.h"

void muxx_check_quantums();
void muxx_check_timers(); 

void muxx_clock_handler(void *FP) {
  utimeticks++;
  if (--clkcountdown == 0) {
    clkcountdown = clkquantum;
    muxx_check_quantums();
  }

  muxx_check_timers();

}

void muxx_check_quantums() {
  PTCB tcb = curtcb;
  tcb->clockTicks += 1;
  char buff[80];
  char buffnum[5];

  WORD *wticks = (WORD *) &utimeticks;
  wticks++;

  // putstr("Ticks: ",7);
  // dtoa(*wticks,buffnum);
  // putstrl(buffnum,5);

  kputstr(".",1);

  if (curtcb != NULL) {
    curtcb->clockTicks++;
  }

  if (readyq->count > 0) {
    curtcb->status = TSK_READY;
    copytrapf();
    muxx_qAddTask(readyq,curtcb);
  
    tcb = muxx_qGetTask(readyq);
    tcb->status = TSK_RUN;
    curtcb = tcb;
    restoretrapf();
  }
}

void muxx_check_timers() {
}

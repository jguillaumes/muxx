#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"


static char msga[] = ">>> CCC - This is task C - CCC <<<"; 

main() {
  int n=0;
  WORD toptask,endcode;
  TCB mytcb;

  toptask = curtcb->taskTUCB->toptask;
  endcode = curtcb->taskTUCB->endcode;
  printf("TASKB - Top of code: %06o, top of task: %06o\n", endcode, toptask);

  for(;;) {
    gettpi(0, &mytcb);
    printf("This is TASKB - Ticks: %ld\n", mytcb.clockTicks);
    sleep(2);
  }
}

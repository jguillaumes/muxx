#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"
#include "muxxdef.h"

static char msga[] = ">>> CCC - This is task C - CCC <<<"; 

main() {
  int n=0;
  WORD toptask,endcode;

  toptask = curtcb->taskTUCB->toptask;
  endcode = curtcb->taskTUCB->endcode;

  printf("TASKA - TCB: %o, TUCB: %o\n", curtcb, curtcb->taskTUCB);
  printf("TASKA - Top of code: %06o, top of task: %06o\n", endcode, toptask); 

  for(;;) {
    printf("This is TASKA\n");
    sleep(1);
  }
}

#include "muxx.h"
#include "externals.h"
#include "muxxdef.h"
#include "kernfuncs.h"

int muxx_yield() {
  curtcb->status = TSK_READY;
  // copyMMUstate();
  // muxx_dumptcb(curtcb);  
  muxx_qAddTask(readyq,curtcb);
  return 0;
}

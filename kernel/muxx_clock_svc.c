#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "config.h"
#include "externals.h"

void muxx_check_quantums() {
  PTCB tcb = curtcb;
  tcb->clockTicks += 1;

  kputstr(".",1);
}

void muxx_check_timers() {
}

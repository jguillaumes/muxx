#include "types.h"
#include "muxxdef.h"
#include "muxx.h"
#include "config.h"
#include "externals.h"

void muxx_check_quantums() {
  PTCB tcb = curtcb;
  tcb->clockTicks += 1;
  char buff[80];
  char buffnum[5];

  LONGWORD *ticks = (LONGWORD *) 01066;
  WORD *wticks = (WORD *) ticks;

  kputstr("Ticks: ",7);
  dtoa(*wticks,buffnum);
  kputstrl(buffnum,5);

  // kputstr(".",1);
}

void muxx_check_timers() {
}

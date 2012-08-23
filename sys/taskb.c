#include "muxx.h"

static char msgb[] = ">>> BBB - This is task B - BBB <<<"; 

taskb() {
  for(;;) {
    //    asm("wait");
    putstrzl(msgb);
  }
}

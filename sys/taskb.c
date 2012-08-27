#include "muxx.h"

static char msgb[] = ">>> BBB - This is task B - BBB <<<"; 

taskb() {
  int i;
  TCB myself;


  for (;;) {
    for(i=0;i<3;i++) {
//      gettpi(0,&myself);
//      putstrz("\n\rPID: "); putoct(myself.pid); putstrzl(".");
      putstrzl(msgb);
    }
    yield();
  }
}

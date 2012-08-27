#include "muxx.h"

static char msgb[] = ">>> BBB - This is task B - BBB <<<"; 

taskb() {
  int i;
  TCB myself;


  for (;;) {
    for(i=0;i<3;i++) {
      printf("\nPID buffer address: %o\n", &myself);
      gettpi(0,&myself);
      printf("\nTASK B. Name: %s, PID: %o, ticks: %d\n", 
	     myself.taskname,myself.pid,myself.clockTicks);
    }
    yield();
  }
}

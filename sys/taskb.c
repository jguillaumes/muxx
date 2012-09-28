#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"

extern WORD toptask;
extern WORD end;

taskb() {
  int n=0;
  WORD pid;

  pid = getpid();
  printf("Starting task B, PID=%06o\n", pid);

  for(;;) {
    n = allocw("PTPDRV  ", DRV_ALLOC);
    if (n != 0) { 
      printf("TASKB - Error allocw: %d.\n", n);
      perror("TASKB: ");
    }
    else { 
      printf("TASKB - Allocated at %8ld.\n",utimeticks);
    }
    sleep(1);
    n = alloc("PTPDRV  ", DRV_DEALLOC);
    if (n==0) {
      printf("TASKB - Deallocated at %6ld.\n", utimeticks);
      sleep(1);
    } else {
      perror("TASKB - Dealloc");
    }
  }
}

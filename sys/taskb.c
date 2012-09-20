#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"

extern WORD toptask;
extern WORD end;

taskb() {
  int n=0;
 
  for(;;) {
    n = allocw("PTPDRV  ", DRV_ALLOC);
    if (n != 0) 
      printf("TASKB - Error allocw: %d.\n", n);
    else 
      printf("TASKB - Allocated at %06l.\n",utimeticks);
    sleep(2);
    allocw("PTPDRV  ", DRV_DEALLOC);
    printf("TASKB - Deallocated at %6l.\n", utimeticks);
    sleep(1);
  }
}

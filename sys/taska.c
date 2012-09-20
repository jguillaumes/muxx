#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"

extern WORD toptask;
extern WORD end;

taska() {
  int n=0;
 
  for(;;) {
    n = allocw("PTPDRV  ", DRV_ALLOC);
    if (n != 0) 
      printf("TASKA - Error allocw: %d.\n", n);
    else 
      printf("TASKA - Allocated at %-6l.\n",utimeticks);
    sleep(3);
    allocw("PTPDRV  ", DRV_DEALLOC);
    printf("TASKA - Deallocated at %-6l.\n", utimeticks);
    sleep(1);
  }
}

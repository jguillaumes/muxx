#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"
#include "errno.h"

taska() {
  int n=0;
  int fd=0;
  WORD pid;
 
  pid = getpid();
  printf("Starting task A, PID=%06o\n", pid);

  for(;;) {
    n = allocw("PTPDRV  ", DRV_ALLOC); 
    fd = open("PT",0);
    if (fd < 0) {
      printf("Error opening PT, %d\n", fd);
      perror("TASKA-OPEN");
    } else {
      printf("Device PT opened, FD=%d\n", fd);
    }
    sleep(1);
    if (fd>=0) {
      n=close(fd);
      if (n<0) {
	printf("Error closing PT, %d\n", n);
	perror("TASKA-CLOSE");
      } else {
	printf("FD %d closed\n", fd);
	allocw("PTPDRV  ", DRV_DEALLOC);
      }
      sleep(3);
    }
  }
}

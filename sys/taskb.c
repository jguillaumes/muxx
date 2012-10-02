#include <stdio.h>
#include <errno.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"


extern WORD toptask;
extern WORD end;

taskb() {
  int n=0,fd=-1;
  WORD pid;
  char buffer[10];

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

    fd = open("PT",0);
    if (fd < 0) {
      printf("Error opening PT: %d\n", fd);
      perror("TASKB-OPEN");
   } else {
      printf("Channel opened, fd=%d\n", fd);
      n = read(fd, 10, buffer);
      if (n>0) {
	printf("Data read: [");
	putstr(buffer,n);
	printf("]\n");
	if (n<10) {
	  printf("Incomplete read."); perror("reason ");
	}
      } else {
	printf("Error reading: %d\n", errno);
	perror("TASKB-READ");
      }
    }

    close(fd);
    printf("Channel closed\n");
    n = alloc("PTPDRV  ", DRV_DEALLOC);
    if (n==0) {
      printf("TASKB - Deallocated at %6ld.\n", utimeticks);
      sleep(1);
    } else {
      perror("TASKB - Dealloc");
    }
  }
}

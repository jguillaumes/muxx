#include <stdio.h>
#include <errno.h>
#include "muxx.h"
#include "muxxdef.h"
#include "muxxlib.h"
#include "externals.h"

main() {
  int n=0,fd=-1;
  WORD pid;
  char buffer[10];
  TCB mytcb;

  pid = getpid();
  printf("Starting task D, PID=%06o\n", pid);

  for(;;) {
    n = allocw("LPTDRV  ", DRV_ALLOC);
    if (n != 0) { 
      printf("TASKD - Error allocw: %d.\n", n);
      perror("TASKD: ");
    }
    else { 
      printf("TASKD - Allocated at %8ld.\n",utimeticks);
    }
    
    fd = open("LP      ",0);
    if (fd < 0) {
      printf("Error opening LPT: %d\n", fd);
      perror("TASKD-OPEN");
   } else {
      printf("Channel opened\n");
      sleep(3);

      printf("Channel opened, fd=%d\n", fd);

      gettpi(0, &mytcb);

      n = write(fd, 10, "Test line\n"); // , mytcb.clockTicks);
      if (n>0) {
	printf("Writen %d bytes\n",n);
	if (n<10) {
	  printf("Incomplete write."); perror("reason ");
	}
      } else {
	printf("Error writing: %d\n", errno);
	perror("TASKD-WRITE");
      }
    }

    close(fd);
    printf("Channel closed\n");

    n = alloc("LPTDRV  ", DRV_DEALLOC);
    if (n==0) {
      printf("TASKD - Deallocated at %6ld.\n", utimeticks);
      sleep(1);
    } else {
      perror("TASKD - Dealloc");
    }
  }
}

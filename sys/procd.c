#include <stdio.h>
#include <errno.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"


extern WORD toptask;
extern WORD end;

procd() {
  int n=0,fd=-1;
  WORD pid;
  char buffer[10];

  pid = getpid();
  printf("Starting task B, PID=%06o\n", pid);

  for(;;) {
    fd = open("LP      ",0);
    if (fd < 0) {
      perror("TASKD-OPEN");
   } else {
      printf("Channel opened, fd=%d\n", fd);
      n = write(fd, 12, "Test line.\n");
      if (n>0) {
	printf("Writen %d bytes\n",n);
	if (n<12) {
	  perror("Incomplete write.");
	}
      } else {
	perror("TASKD-WRITE");
      }
    }

    close(fd);
    printf("Channel closed\n");
  }
}

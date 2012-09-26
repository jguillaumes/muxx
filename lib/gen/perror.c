#include <stdio.h>
#include "externals.h"
#include "errno.h"

void perror(char *msg) {
  if (msg != NULL) printf("%s: ", msg);

  switch(curtcb->taskTUCB->errno) {
  case ENOMEM:
    printf("Not enough memory\n");
    break;
  case EMAXTASK:
    printf("The system can't execute more tasks\n");
    break;
  case ENOPID:
    printf("The system can't allocate a PID number\n");
    break;
  case ETCTFULL:
    printf("The system task table is full\n");
    break;
  case EILLINST:
    printf("Illegal instruction\n");
    break;
  case EINVVAL:
    printf("Invalid value\n");
    break;
  case ENOPRIV:
    printf("No privileges for the attempted operation\n");
    break;
  case ELOCKED:
    printf("The resource is locked\n");
    break;
  case ENOAVAIL:
    printf("No available resources\n");
    break;
  case ENOTALLOC:
    printf("The device is not allocated\n");
    break;
  case ENOTFOUND:
    printf("The resource could not be found\n");
    break;
  case ERRDEV:
    printf("The device reported an error\n");
    break;
  case EOFFLINE:
    printf("The device is offline\n");
    break;
  case ENOSYSRES:
    printf("The system has insufficient resources to execute the operation\n");
    break;
  case ENOTOPEN:
    printf("The channel is not opened\n");
  default:
    printf("ERRNO: %d\n", curtcb->taskTUCB->errno);
    break;
  }
}

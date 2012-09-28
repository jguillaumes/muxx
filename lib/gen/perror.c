#include <stdio.h>
#include "externals.h"
#include "errno.h"

void perror(char *msg) {
  if (msg != NULL) printf("%s: ", msg);

  switch(curtcb->taskTUCB->errno) {
  case ENOMEM:
    printf("ENOMEM\n");
    break;
  case EMAXTASK:
    printf("EMAXTASK\n");
    break;
  case ENOPID:
    printf("ENOPID\n");
    break;
  case ETCTFULL:
    printf("ETCTFULL\n");
    break;
  case EILLINST:
    printf("EILLINST\n");
    break;
  case EINVVAL:
    printf("EINVVAL\n");
    break;
  case ENOPRIV:
    printf("ENOPRIV\n");
    break;
  case ELOCKED:
    printf("ELOCKED\n");
    break;
  case ENOAVAIL:
    printf("ENOAVAIL\n");
    break;
  case ENOTALLOC:
    printf("ENOTALLOC\n");
    break;
  case ENOTFOUND:
    printf("ENOTFOUND\n");
    break;
  case ERRDEV:
    printf("ERRDEV\n");
    break;
  case EOFFLINE:
    printf("EOFFLINE\n");
    break;
  case ENOSYSRES:
    printf("ENOSYSRES\n");
    break;
  case ENOTOPEN:
    printf("ENOTOPEN\n");
  default:
    printf("ERRNO: %d\n", curtcb->taskTUCB->errno);
    break;
  }
}

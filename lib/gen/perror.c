#include <stdio.h>
#include "externals.h"
#include "errno.h"

void perror(char *msg) {
  if (msg != NULL) putstrl("%s: ", msg);

  switch(errno) {
  case ENOMEM:
    putstrl("ENOMEM\n");
    break;
  case EMAXTASK:
    putstrl("EMAXTASK\n");
    break;
  case ENOPID:
    putstrl("ENOPID\n");
    break;
  case ETCTFULL:
    putstrl("ETCTFULL\n");
    break;
  case EILLINST:
    putstrl("EILLINST\n");
    break;
  case EINVVAL:
    putstrl("EINVVAL\n");
    break;
  case ENOPRIV:
    putstrl("ENOPRIV\n");
    break;
  case ELOCKED:
    putstrl("ELOCKED\n");
    break;
  case ENOAVAIL:
    putstrl("ENOAVAIL\n");
    break;
  case ENOTALLOC:
    putstrl("ENOTALLOC\n");
    break;
  case ENOTFOUND:
    putstrl("ENOTFOUND\n");
    break;
  case ERRDEV:
    putstrl("ERRDEV\n");
    break;
  case EOFFLINE:
    putstrl("EOFFLINE\n");
    break;
  case ENOSYSRES:
    putstrl("ENOSYSRES\n");
    break;
  case ENOTOPEN:
    putstrl("ENOTOPEN\n");
  case EEOF:
    putstrl("EEOF\n");
  default:
    putstrl("ERRNO: %d\n", errno);
    break;
  }
}

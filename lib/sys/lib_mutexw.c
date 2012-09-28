#include "muxx.h"
#include "muxxlib.h"
#include "muxxdef.h"
#include "errno.h"

int mutexw(char *devnam, WORD mode) {
  int rc;
  int done=0;
  
  while(done == 0) {
    rc = mutex(devnam, mode);
    if (rc == ELOCKED) {
      yield();
    } else {
      done = 1;
    }
  }
  return rc;
}

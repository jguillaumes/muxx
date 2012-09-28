#include "muxx.h"
#include "muxxlib.h"
#include "muxxdef.h"
#include "errno.h"

int allocw(char *devnam, WORD mode) {
  int rc;
  int done=0;

  
  while(done == 0) {
    DPRINTF("PID %6o trying to alloc ", getpid()); DPUTSTRL(devnam,8);
    rc = alloc(devnam, mode);
    if (rc == ENOAVAIL || rc == ELOCKED) {
      yield();
    } else {
      done = 1;
    }
    if (rc != 0) {
      DPRINTF("Alloc failed, rc=%d\n",rc);
    }
  }
  return rc;
}

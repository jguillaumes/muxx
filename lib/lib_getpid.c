#include "muxx.h"
#include "muxxlib.h"

WORD getpid() {
  int rc;
  TCB thisTask;
  if ((rc = gettpi(0,&thisTask)) == 0) {
    return thisTask.pid;
  }
  return rc;
}

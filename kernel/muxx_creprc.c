#include <string.h>
#include "muxx.h"
#include "config.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"
#include "queues.h"
#include "kernfuncs.h"



int muxx_svc_creprc(ADDRESS fp, char *name, int type, ADDRESS entry, WORD privs) {
  PTCB newTask = NULL;
  int pididx = 0;

  pididx = muxx_taskinit(type, curtcb->pid, entry, privs);
  newTask = &(tct->tctTable[pididx]);
  memcpy(newTask->taskname, name, 8);
  if (muxx_setup_taskmem(newTask) != EOK) {
    return -1;
  } else {
    muxx_qAddTask(readyq, newTask);
    return newTask->pid;
  }
}

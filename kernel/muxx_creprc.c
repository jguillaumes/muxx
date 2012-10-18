#include <string.h>
#include "muxx.h"
#include "config.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"
#include "queues.h"
#include "kernfuncs.h"
#include "a.out.h"

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

int muxx_svc_loadprc(ADDRESS fp, char *name, int type, char *file, WORD privs) {
  PTCB newTask = NULL;
  int pididx = 0, rc=0;
  extern int rshell();
  int (*shellproc)() = &rshell;
  char *fnam = (char *) TASK_BASE;

  kprintf("rshell=%o\n", rshell);

  pididx = muxx_taskinit(type, curtcb->pid, shellproc, privs);
  newTask = &(tct->tctTable[pididx]);
  memcpy(newTask->taskname, name, 8);
  if (muxx_setup_taskmem(newTask) != EOK) {
    return -1;
  } else {
    rc = muxx_svc_xcopy(fp, newTask->pid, (WORD) fnam, curtcb->pid, (WORD) file, strlen(file));
    if (rc >= 0) {
      muxx_qAddTask(readyq, newTask);
      return newTask->pid;
    } else {
      // TO-DO: Destroy aborted task
      panic("Abort creating task - LOADPRC");
      return rc;
    }
  }
}


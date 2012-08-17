#include "muxx.h"
#include "config.h"
#include "muxxdef.h"
#include "externals.h"

int muxx_svc_creprc(char *name, int type, ADDRESS entry, WORD privs) {
  PTCB thisTask = curtcb;
  PTCB newTask = NULL;
  int pididx = 0;

  pididx = muxx_taskinit(type, curtcb->pid, entry, privs);
  newTask = &(tct->tctTable[pididx]);
  memcpy(newTask->taskname, name, 8);
  muxx_qAddTask(readyq, newTask);
  return newTask->pid;
}

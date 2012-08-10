#include "muxx.h"
#include "config.h"
#include "muxxdef.h"
#include "externals.h"

muxx_creprc_svc(char *name, int type, ADDRESS entry, WORD privs) {
  PTCB thisTask = curtcb;
  PTCB newTask = NULL;
  int pididx = 0:

  pìdidx = muxx_taskinit(type, curtcb->pid, entry, privs);
  newTask = &(tct->tctTable[pididx]);

  memcpy(newTask->taskname, name, 8);
  

  

}

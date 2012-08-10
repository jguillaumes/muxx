#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"

int muxx_taskinit(int type, WORD ppid, ADDRESS entry, WORD privs) {
  WORD pid = 0;
  int i=0,found=0;
  PTCTA ptcta;

  if (curtasks >= MAX_TASKS) {
    return EMAXTASK;
  }
  ptcta = tct;

  switch(type) {
  case SYS_TASK:
    pid = maxspid + 1;
    if (pid > topspid) {
      pid = reusespid();
    } else {
      maxspid++;
    }
    break;
  case USR_TASK:
  default:
    pid = maxupid + 1;
    if (pid > topupid) {
      pid = reuseupid();
    } else {
      maxupid++;
    }
    break;
  }
  if (pid <= 0) {
    return ENOPID;
  }

  for (i=0; i<MAX_TASKS & found == 0; i++) {
    if (ptcta->tctTable[i].pid == 0) found = 1; 
  } 

  if (!found) panic(ETCTFULL);

  muxx_tcbinit(&(ptcta->tctTable[i]));
  ptcta->tctTable[i].ppid = ppid;
  ptcta->tctTable[i].taskType = type;
  ptcta->tctTable[i].privileges.prvword = privs;
  ptcta->tctTable[i].cpuState.pc = (WORD) entry;
  ptcta->tctTable[i].status = TSK_INIT;

  return i;
}

int reusespid() {
  panic();
}

int reuseupid() {
  panic();
}

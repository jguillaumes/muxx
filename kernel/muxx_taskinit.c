#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"
#include "errno.h"
#include "kernfuncs.h"

int reusespid() {
  panic("REUSESPID");
  return(0);
}

int reuseupid() {
  panic("REUSEUPID");
  return(0);
}


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
    pid = topspid + 1;
    if (pid > maxspid) {
      pid = reusespid();
    } else {
      topspid++;
    }
    break;
  case USR_TASK:
  default:
    pid = topupid + 1;
    if (pid > maxupid) {
      pid = reuseupid();
    } else {
      topupid++;
    }
    break;
  }
  if (pid <= 0) {
    return ENOPID;
  }

  for (i=0; i<MAX_TASKS && found==0; i++) {
    if (ptcta->tctTable[i].pid == 0) found = i; 
  } 

  if (!found) panic("TCT full");

  muxx_tcbinit(&(ptcta->tctTable[found]));
  ptcta->tctTable[found].pid = pid;
  ptcta->tctTable[found].ppid = ppid;
  ptcta->tctTable[found].taskType = type;
  ptcta->tctTable[found].privileges.prvword = privs;
  ptcta->tctTable[found].cpuState.pc = (WORD) entry;
  ptcta->tctTable[found].cpuState.psw = 0xC000;      // User mode, interrupts on
  ptcta->tctTable[found].cpuState.sp =  (WORD) ustackt;
  ptcta->tctTable[found].cpuState.usp = (WORD) ustackt;
  ptcta->tctTable[found].cpuState.ksp = (WORD) kstackt;
  ptcta->tctTable[found].status = TSK_INIT;


  return found;
}


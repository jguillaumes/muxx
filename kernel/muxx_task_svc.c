#include "muxx.h"
#include "muxxdef.h"
#include "errno.h"
#include "config.h"
#include "kernfuncs.h"
#include "muxxlib.h"
#include "externals.h"
#include <string.h>

PTCB muxx_findtcb(WORD pid) {
  int i=0;

  if (pid == 0) return curtcb;
  for (i=0; i<MAX_TASKS; i++) {
    if (tct->tctTable[i].pid == pid) {
      return &(tct->tctTable[i]);
    }
  }
  return NULL;
}

int muxx_svc_gettpi(ADDRESS fp, WORD pid, PTCB area) {
  PTCB source = NULL;
  if (pid == 0) {
    source = curtcb;
  } else {
    source = muxx_findtcb(pid);
  }
  if ((source->uic == curtcb->uic) || 
      curtcb->privileges.prvflags.operprv ||
      curtcb->privileges.prvflags.auditprv ) {
    memcpy(area, source, sizeof(TCB));
  } else {
    return ENOPRIV;
  }
  return EOK;
}

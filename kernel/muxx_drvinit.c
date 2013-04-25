#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"
#include "kernfuncs.h"
// #include <string.h>

/*
** Initialization of the device driver table (DRVCBT)
*/

void muxx_drvinit() {
  int i;

  memcpy(drvcbtaddr->eyecat, "DRVCBT--", 8);
  for(i=0;i<MAX_DRV;i++) {
    memcpy(drvcbtaddr->drvcbt[i].drvname, "        ", 8);
    drvcbtaddr->drvcbt[i].desc = NULL;
    drvcbtaddr->drvcbt[i].flags.free = 1;
    drvcbtaddr->drvcbt[i].flags.loaded = 0;
    drvcbtaddr->drvcbt[i].flags.active = 0;
    drvcbtaddr->drvcbt[i].flags.stopped = 0;    
    drvcbtaddr->drvcbt[i].flags.reserved = 0;
    drvcbtaddr->drvcbt[i].taskid = 0;    
    drvcbtaddr->drvcbt[i].status = 0;    
  }
}

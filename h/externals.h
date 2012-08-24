#ifndef _EXTERNALS_H

#include "types.h"
#include "muxx.h"
#include "queues.h"

extern PTCTA tct;
extern WORD tctsize;
extern WORD curtasks;
extern PTQUEUE readyq;
extern PTQUEUE blockq;
extern PTQUEUE suspq;
extern PTCB curtcb;

extern ADDRESS kstackt;
extern ADDRESS kstackb;
extern ADDRESS ustackt;
extern ADDRESS ustackb;

extern PMMCBT mmcbtaddr;

extern WORD topspid;
extern WORD minspid;
extern WORD maxspid;

extern WORD topupid;
extern WORD minupid;
extern WORD maxupid;

extern WORD clkfreq;
extern LONGWORD utime;
extern LONGWORD datetime;

extern LONGWORD utimeticks;
extern WORD clkcountdown;
extern WORD clkquantum;

extern BYTE muxx_latches[LTC_LATCHES];

#define _EXTERNALS_H
#endif

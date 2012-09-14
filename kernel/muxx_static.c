#include "muxx.h"
#include "queues.h"
#include "muxxdef.h"

TCTA tctArea __attribute__ ((common)) = {0};
int tctSize __attribute__ ((common)) = sizeof(tctArea);

TQUEUE readyQueue  __attribute__ ((common)) = {0};   // Ready queue
TQUEUE blockedQueue  __attribute__ ((common)) = {0}; // Blocked list
TQUEUE suspQueue  __attribute__ ((common)) = {0};    // Suspended list

MMCBT mmcbt __attribute__ ((common)) = {0};

DRVCBT drvcbt __attribute__ ((common)) = {0};

BYTE muxx_mutexes[MUT_MUTEXES] __attribute__ ((common)) = {0}; // System latches


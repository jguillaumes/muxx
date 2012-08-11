#include "muxx.h"
#include "queues.h"
#include "muxxdef.h"

TCTA tctArea __attribute__ ((common));
int tctSize __attribute__ ((common)) = sizeof(tctArea);

TQUEUE readyQueue  __attribute__ ((common));   // Ready queue
TQUEUE blockedQueue  __attribute__ ((common)); // Blocked list
TQUEUE suspQueue  __attribute__ ((common));    // Suspended list

MCB mcb __attribute__ ((common));

BYTE muxx_latches[LTC_LATCHES] __attribute__ ((common)); // System latches


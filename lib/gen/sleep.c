#include "muxxlib.h"
#include "types.h"
#include "config.h"
#include "externals.h"


/*
** Provisional version of sleep()
**
** This version uses the raw number of clicks instead of
** the time of day. It yields control of the processor
** and loops until the specified number of seconds has passed
*/

WORD sleep(int seconds) {
  if (seconds == 0) return 0;
  LONGWORD sticks = seconds * CLK_FREQ;
  LONGWORD ticks = utimeticks;

  while((utimeticks - ticks) < sticks) { 
    yield();
  }
  return(0);
}

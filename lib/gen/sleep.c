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

int sleep(int seconds) {
  if (seconds == 0) return 0;

  LONGWORD sticks;
  LONGWORD ticks;
 
  sticks = seconds * CLK_FREQ;
  ticks = utimeticks;
 
  // printf("Utimeticks: %l, ticks: %l\n", utimeticks, ticks);

  while((utimeticks - ticks) < sticks) { 
    yield();
  }
  return(0);
}

#include "muxx.h"

static char msgb[] = ">>> BBB - This is task B - BBB <<<"; 

taskb() {
  for(;;)   kputstrl(msgb,sizeof(msgb)-1);
}

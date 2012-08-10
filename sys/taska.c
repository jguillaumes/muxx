#include "muxx.h"

static char msga[] = ">>> AAA - This is task A - AAA <<<"; 

taska() {
  for(;;)   kputstr(msga,sizeof(msga)-1);
}

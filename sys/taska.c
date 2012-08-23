#include "muxx.h"

static char msga[] = ">>> AAA - This is task A - AAA <<<\r\n"; 

taska() {
  for(;;) {
    // asm ("wait");
    putstrz(msga);
  }
}

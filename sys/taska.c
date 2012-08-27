#include "muxx.h"

static char msga[] = ">>> AAA - This is task A - AAA <<<\r\n"; 

taska() {
  for(;;) {
    putstrz(msga);
//    yield();
  }
}
